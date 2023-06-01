// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { MudV2Test } from "@latticexyz/std-contracts/src/test/MudV2Test.t.sol";
import { LibGuiseLevel } from "../src/guise/LibGuiseLevel.sol";
import { LibExperience } from "../src/charstat/LibExperience.sol";
import { Experience, ExperienceTableId } from "../src/codegen/Tables.sol";
import { ActiveGuise, ActiveGuiseTableId } from "../src/codegen/Tables.sol";
import { GuisePrototype, GuisePrototypeTableId } from "../src/codegen/Tables.sol";
import { PStat_length } from "../src/CustomTypes.sol";
import "forge-std/console.sol";

contract LibGuiseLevelTest is MudV2Test {
  bytes32 internal targetEntity = keccak256("targetEntity");

  function setUp() public virtual override {
    super.setUp();
    vm.startPrank(worldAddress);
  }

  function testGetAggregateLevel() public {
    // Initialize exp and levelMul
    LibExperience.initExp(targetEntity);
    assertTrue(LibExperience.hasExp(targetEntity));

    // Add exp
    uint32[PStat_length] memory addExp = [uint32(1), 1, 1];
    LibExperience.increaseExp(targetEntity, addExp);

    //Add guise and set levelmul
    uint256 guiseProtoEntity = ActiveGuise.get(targetEntity);
    uint32[PStat_length] memory levelMul = [uint32(2), 2, 2];
    GuisePrototype.set(bytes32(guiseProtoEntity), levelMul);

    uint32 aggregateLevel = LibGuiseLevel.getAggregateLevel(bytes32(targetEntity));
    assertEq(aggregateLevel, 1); // expected 1 = (2*1 + 2*1 + 2*1) / (2 + 2 + 2)
  }

  function testMultiplyExperience() public {
    LibExperience.initExp(targetEntity);
    assertTrue(LibExperience.hasExp(targetEntity));

    uint32[PStat_length] memory addExp = [uint32(1), 1, 1];
    LibExperience.increaseExp(targetEntity, addExp);

    uint256 guiseProtoEntity = ActiveGuise.get(targetEntity);
    uint32[PStat_length] memory levelMul = [uint32(2), 2, 2];
    GuisePrototype.set(bytes32(guiseProtoEntity), levelMul);

    uint32[PStat_length] memory expMultiplied = LibGuiseLevel.multiplyExperience(targetEntity, addExp);
    for (uint256 i; i < expMultiplied.length; i++) {
      assertEq(expMultiplied[i], 2);
    }
  }
}
