// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

import { CombatAction, CombatResult, CombatActor } from "./../../CustomTypes.sol";

/**
 * @title ICombatSystem
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface ICombatSystem {
  error CombatSystem_InvalidExecuteSelector();
  error CombatSystem_InvalidActionsLength();
  error CombatSystem_ResidualDuration();

  function executePVERound(
    bytes32 userEntity,
    bytes32 initiatorEntity,
    bytes32 retaliatorEntity,
    CombatAction[] memory initiatorActions,
    CombatAction[] memory retaliatorActions
  ) external returns (CombatResult result);

  function executeCombatRound(
    CombatActor memory initiator,
    CombatActor memory retaliator,
    bytes32 userEntity
  ) external returns (CombatResult result);

  function executeActivateCombat(bytes32 initiatorEntity, bytes32 retaliatorEntity, uint256 maxRounds) external;

  function executeDeactivateCombat(bytes32 initiatorEntity) external;
}
