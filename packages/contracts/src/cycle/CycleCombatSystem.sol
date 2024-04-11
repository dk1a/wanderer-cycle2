// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { System } from "@latticexyz/world/src/System.sol";

import { ActionType } from "../codegen/common.sol";
import { Action } from "../combat/LibCombatAction.sol";
import { CombatSystem } from "../combat/CombatSystem.sol";

import { LibActiveCombat } from "../combat/LibActiveCombat.sol";
import { LibCycle } from "./LibCycle.sol";
import { LibCycleCombatRewardRequest } from "./LibCycleCombatRewardRequest.sol";

contract CycleCombatSystem is System {
  function execute(bytes memory args) public override returns (bytes memory) {
    (bytes32 wandererEntity, Action[] memory initiatorActions) = abi.decode(args, (bytes32, bytes32[]));
    // reverts if sender doesn't have permission
    bytes32 cycleEntity = LibCycle.getCycleEntityPermissioned(wandererEntity);
    // reverts if combat isn't active
    bytes32 retaliatorEntity = LibActiveCombat.getRetaliatorEntity(cycleEntity);

    // TODO other retaliator actions?
    Action[] memory retaliatorActions = new Action[](1);
    retaliatorActions[0] = Action({ actionType: ActionType.ATTACK, actionEntity: 0 });

    CombatSystem.CombatResult result = CombatSystem.executePVERound(
      cycleEntity,
      retaliatorEntity,
      initiatorActions,
      retaliatorActions
    );

    if (result == CombatSystem.CombatResult.VICTORY) {
      LibCycleCombatRewardRequest.requestReward(cycleEntity, retaliatorEntity);
    }

    return result;
  }
}
