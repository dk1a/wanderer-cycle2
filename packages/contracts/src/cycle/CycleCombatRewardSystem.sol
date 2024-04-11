// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { System } from "@latticexyz/world/src/System.sol";

import { RandomEquipmentSystem } from "../loot/RandomEquipmentSubSystem.sol";

import { LibCycle } from "./LibCycle.sol";
import { LibActiveCombat } from "../combat/LibActiveCombat.sol";
import { LibCycleCombatRewardRequest } from "./LibCycleCombatRewardRequest.sol";
import { LibExperience, PS_L } from "../charstat/LibExperience.sol";
import { LibLootOwner } from "../loot/LibLootOwner.sol";
import { LibGuiseLevel } from "../guise/LibGuiseLevel.sol";
import { LibRNG } from "../rng/LibRNG.sol";

contract CycleCombatRewardSystem is System {
  error CycleCombatRewardSystem__UnknownMapPrototype();

  function reward(bytes memory args) public override returns (bytes memory) {
    (bytes32 wandererEntity, bytes32 requestId) = abi.decode(args, (bytes32, bytes32));
    // reverts if sender doesn't have permission
    bytes32 cycleEntity = LibCycle.getCycleEntityPermissioned(wandererEntity);
    // TODO decide if claiming exp during combat is actually bad and why
    LibActiveCombat.requireNotActiveCombat(cycleEntity);

    (uint256 randomness, uint32[PS_L] memory exp, uint32 lootIlvl, uint256 lootCount) = LibCycleCombatRewardRequest
      .popReward(cycleEntity, requestId);

    // multiply awarded exp by guise's multiplier
    exp = LibGuiseLevel.multiplyExperience(cycleEntity, exp);

    // give exp
    LibExperience.__construct(cycleEntity).increaseExp(exp);

    // give loot
    for (uint256 i; i < lootCount; i++) {
      bytes32 lootEntity = RandomEquipmentSystem.executeTyped(lootIlvl, randomness);
      LibLootOwner.setSimpleOwnership(lootEntity, cycleEntity);
    }

    return "";
  }

  function cancelRequest(bytes32 wandererEntity, bytes32 requestId) public {
    // reverts if sender doesn't have permission
    bytes32 cycleEntity = LibCycle.getCycleEntityPermissioned(wandererEntity);
    // remove the reward without claiming it
    LibRNG.removeRequest(cycleEntity, requestId);
  }
}
