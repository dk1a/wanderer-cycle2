// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { System } from "@latticexyz/world/src/System.sol";

import { ActiveCombat, GenericDurationData } from "../codegen/index.sol";
import { CombatActionType } from "../codegen/common.sol";
import { CombatResult, CombatAction, CombatActorOpts, CombatActor } from "../CustomTypes.sol";

import { LibTime } from "../LibTime.sol";
import { LibActiveCombat } from "./LibActiveCombat.sol";
import { LibCharstat } from "../charstat/LibCharstat.sol";
import { LibCombatAction } from "./LibCombatAction.sol";
import { CombatResult } from "../CustomTypes.sol";

/**
 * @title Subsystem to execute 1 combat round between 2 actors; extensively uses charstats.
 * @dev A combat may have multiple rounds, each executed separately.
 * `CombatAction[]` in args allows multiple actions in 1 round. (For another round call execute again).
 * `CombatSubsystem` has multi-actor multi-action interactions logic,
 * and uses `LibCombatAction` for reusable one-way action logic.
 */
contract CombatSystem is System {
  error CombatSystem_InvalidExecuteSelector();
  error CombatSystem_InvalidActionsLength();
  error CombatSystem_ResidualDuration();

  /**
   * @notice Execute a combat round with default PVE options
   * @dev Player must be the initiator
   */
  function executePVERound(
    bytes32 userEntity,
    bytes32 initiatorEntity,
    bytes32 retaliatorEntity,
    CombatAction[] memory initiatorActions,
    CombatAction[] memory retaliatorActions
  ) public returns (CombatResult result) {
    CombatActor memory initiator = CombatActor({
      entity: initiatorEntity,
      actions: initiatorActions,
      opts: CombatActorOpts({ maxResistance: 80 })
    });
    CombatActor memory retaliator = CombatActor({
      entity: retaliatorEntity,
      actions: retaliatorActions,
      opts: CombatActorOpts({ maxResistance: 99 })
    });
    result = executeCombatRound(initiator, retaliator, userEntity);

    return result;
  }

  /**
   * @notice Execute a combat round with generic actors
   */
  function executeCombatRound(
    CombatActor memory initiator,
    CombatActor memory retaliator,
    bytes32 userEntity
  ) public returns (CombatResult result) {
    // TODO (maybe this check doesn't need to be here?)
    // combat should be externally activated
    LibActiveCombat.requireActiveCombat(initiator.entity, retaliator.entity);

    result = _bothActorsActions(initiator, retaliator, userEntity);

    if (result != CombatResult.NONE) {
      // combat ended - deactivate it
      executeDeactivateCombat(initiator.entity);
    } else {
      // combat keeps going - decrement round durations
      LibTime.decreaseApplications(
        initiator.entity,
        GenericDurationData({ timeScopeId: keccak256("round"), timeValue: 1 })
      );
      LibTime.decreaseApplications(
        initiator.entity,
        GenericDurationData({ timeScopeId: keccak256("round_persistent"), timeValue: 1 })
      );
      // if combat duration ran out, initiator loses by default
      uint32 roundsSpent = ActiveCombat.getRoundsSpent(initiator.entity);
      uint32 roundsMax = ActiveCombat.getRoundsMax(initiator.entity);

      if (roundsSpen == roundsMax) {
        executeDeactivateCombat(initiator.entity);
        result = CombatResult.DEFEAT;
      }
    }

    return result;
  }

  /**
   * @notice Combat must be activated first, then `executeCombatRound` can be called until it's over
   */
  function executeActivateCombat(bytes32 initiatorEntity, bytes32 retaliatorEntity, uint32 maxRounds) public {
    LibActiveCombat.requireNotActiveCombat(initiatorEntity);

    LibActiveCombat.spendingRounds(initiatorEntity, retaliatorEntity, 1);

    LibTime.decreaseApplications(
      initiatorEntity,
      GenericDurationData({ timeScopeId: keccak256("round"), timeValue: type(uint256).max })
    );
  }

  /**
   * @notice Mostly for internal use, but it can also be called to prematurely deactivate combat
   */
  function executeDeactivateCombat(bytes32 initiatorEntity) public {
    ActiveCombat.deleteRecord(initiatorEntity);

    LibTime.decreaseApplications(
      initiatorEntity,
      GenericDurationData({ timeScopeId: keccak256("round"), timeValue: type(uint256).max })
    );
    LibTime.decreaseApplications(
      initiatorEntity,
      GenericDurationData({ timeScopeId: keccak256("turn"), timeValue: 1 })
    );
  }

  /*//////////////////////////////////////////////////////////////
                              INTERNAL
  //////////////////////////////////////////////////////////////*/

  function _execute(bytes memory args) internal override returns (bytes memory) {
    (bytes4 executeSelector, bytes memory innerArgs) = abi.decode(args, (bytes4, bytes));

    if (executeSelector == this.executeCombatRound.selector) {
      (CombatActor memory initiator, CombatActor memory retaliator) = abi.decode(innerArgs, (CombatActor, CombatActor));
      return abi.encode(executeCombatRound(initiator, retaliator));
    } else if (executeSelector == this.executeActivateCombat.selector) {
      (bytes32 initiatorEntity, bytes32 retaliatorEntity, uint256 maxRounds) = abi.decode(
        innerArgs,
        (bytes32, bytes32, uint256)
      );
      executeActivateCombat(initiatorEntity, retaliatorEntity, maxRounds);
      return "";
    } else if (executeSelector == this.executeDeactivateCombat.selector) {
      uint256 initiatorEntity = abi.decode(innerArgs, (uint256));
      executeDeactivateCombat(initiatorEntity);
      return "";
    } else {
      revert CombatSystem_InvalidExecuteSelector();
    }
  }

  function _bothActorsActions(
    CombatActor memory initiator,
    CombatActor memory retaliator,
    bytes32 userEntity
  ) internal returns (CombatResult) {
    // instant loss if initiator somehow started with 0 life
    if (LibCharstat.getLifeCurrent(initiator.entity) == 0) return CombatResult.DEFEAT;

    // initiator's actions
    _oneActorActions(userEntity, initiator, retaliator);

    // win if retaliator is dead; this interrupts retaliator's actions
    if (LibCharstat.getLifeCurrent(retaliator.entity) == 0) return CombatResult.VICTORY;

    // retaliator's actions
    _oneActorActions(userEntity, retaliator, initiator);

    // loss if initiator is dead
    if (LibCharstat.getLifeCurrent(initiator.entity) == 0) return CombatResult.DEFEAT;
    // win if retaliator somehow died in its own round
    if (LibCharstat.getLifeCurrent(retaliator.entity) == 0) return CombatResult.VICTORY;
    // none otherwise
    return CombatResult.NONE;
  }

  function _oneActorActions(bytes32 userEntity, CombatActor memory attacker, CombatActor memory defender) internal {
    _checkActionsLength(attacker);

    for (uint256 i; i < attacker.actions.length; i++) {
      LibCombatAction.executeAction(defender.entity, userEntity, attacker.entity, attacker.actions[i], defender.opts);
    }
  }

  function _checkActionsLength(CombatActor memory actor) internal pure {
    if (actor.actions.length > 1) {
      // TODO a way to do 2 actions in a round, like a special skill
      // (limited by actionType, 2 attacks in a round is too OP)
      revert CombatSystem_InvalidActionsLength();
    }
  }
}
