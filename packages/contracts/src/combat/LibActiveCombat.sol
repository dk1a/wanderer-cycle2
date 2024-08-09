// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { ActiveCombat } from "../codegen/index.sol";

library LibActiveCombat {
  error LibActiveCombat__CombatActive();
  error LibActiveCombat__CombatNotActive();
  error LibActiveCombat__CombatActiveForDifferentRetaliator();
  error LibActiveCombat__RoundsAreOver();
  error LibActiveCombat__InvalidSpendingRounds();

  function getRetaliatorEntity(bytes32 initiatorEntity) internal view returns (bytes32 retaliatorEntity) {
    retaliatorEntity = ActiveCombat.getRetaliatorEntity(initiatorEntity);
    if (retaliatorEntity == bytes32(0)) {
      revert LibActiveCombat__CombatNotActive();
    }
  }

  function requireActiveCombat(bytes32 initiatorEntity, bytes32 retaliatorEntity) internal view {
    bytes32 storedRetaliatorEntity = ActiveCombat.getRetaliatorEntity(initiatorEntity);
    if (storedRetaliatorEntity == bytes32(0)) {
      revert LibActiveCombat__CombatNotActive();
    }
    if (storedRetaliatorEntity != retaliatorEntity) {
      revert LibActiveCombat__CombatActiveForDifferentRetaliator();
    }
  }

  function requireNotActiveCombat(bytes32 initiatorEntity) internal view {
    if (ActiveCombat.getRetaliatorEntity(initiatorEntity) != bytes32(0)) {
      revert LibActiveCombat__CombatActive();
    }
  }

  function requireRoundsAreOver(uint32 roundsSpent, uint32 roundsMax) internal pure {
    if (roundsSpent == roundsMax) {
      revert LibActiveCombat__RoundsAreOver();
    }
  }

  function requireInvalidSpendingRounds(uint32 roundsSpent, uint32 roundsMax, uint32 round) internal pure {
    if (roundsSpent + round > roundsMax) {
      revert LibActiveCombat__InvalidSpendingRounds();
    }
  }

  function spendingRounds(bytes32 initiatorEntity, bytes32 retaliatorEntity, uint32 round) public {
    requireActiveCombat(initiatorEntity, retaliatorEntity);

    uint32 roundsSpent = ActiveCombat.getRoundsSpent(initiatorEntity);
    uint32 roundsMax = ActiveCombat.getRoundsMax(initiatorEntity);

    requireRoundsAreOver(roundsSpent, roundsMax);
    requireInvalidSpendingRounds(roundsSpent, roundsMax, round);

    ActiveCombat.setRoundsSpent(initiatorEntity, round + roundsSpent);
  }
}
