// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { MudV2Test } from "@latticexyz/std-contracts/src/test/MudV2Test.t.sol";
import { LibExperience } from "../src/charstat/LibExperience.sol";
import { Experience, ExperienceTableId } from "../src/codegen/Tables.sol";
import { PStat_length } from "../src/CustomTypes.sol";

contract LibExperienceTest is MudV2Test {
  bytes32 internal targetEntity = keccak256("targetEntity");

  function setUp() public virtual override {
    super.setUp();
    // TODO remove this if it's integrated into MUD
    vm.startPrank(worldAddress);
  }

  function testIncreaseExp() public {
    // Initialize exp
    LibExperience.initExp(targetEntity);
    assertTrue(LibExperience.hasExp(targetEntity));

    uint32[PStat_length] memory addExp = [uint32(1), 1, 1];
    LibExperience.increaseExp(targetEntity, addExp);

    uint32[PStat_length] memory exp = LibExperience.getExp(targetEntity);
    for (uint256 i; i < exp.length; i++) {
      assertEq(exp[i], 1);
    }
  }
  function testGetExp() public {
    LibExperience.initExp(targetEntity);
    assertTrue(LibExperience.hasExp(targetEntity));

    uint32[PStat_length] memory addExp = [uint32(1), 1, 1];
    LibExperience.increaseExp(targetEntity, addExp);

    uint32[PStat_length] memory exp = LibExperience.getExp(targetEntity);
    for (uint256 i; i < exp.length; i++) {
      assertEq(exp[i], 1);
    }
}

  function testHasExp() public {
    assertFalse(LibExperience.hasExp(targetEntity));

    LibExperience.initExp(targetEntity);
    assertTrue(LibExperience.hasExp(targetEntity));
}

function testSetExp() public {
  uint32[PStat_length] memory exp = [uint32(10), 20, 30];
  Experience.set(targetEntity, exp);

  uint32[PStat_length] memory retrievedExp = LibExperience.getExp(targetEntity);
  for (uint256 i; i < retrievedExp.length; i++) {
    assertEq(retrievedExp[i], exp[i]);
  }
}

function testAddExp() public {
  LibExperience.initExp(targetEntity);
  assertTrue(LibExperience.hasExp(targetEntity));

  uint32[PStat_length] memory initialExp = LibExperience.getExp(targetEntity);

  uint32[PStat_length] memory addExp = [uint32(5), 10, 15];
  LibExperience.increaseExp(targetEntity, addExp);

  uint32[PStat_length] memory expectedExp;
  for (uint256 i; i < initialExp.length; i++) {
    expectedExp[i] = initialExp[i] + addExp[i];
  }

  uint32[PStat_length] memory retrievedExp = LibExperience.getExp(targetEntity);
  for (uint256 i; i < retrievedExp.length; i++) {
    assertEq(retrievedExp[i], expectedExp[i]);
  }
}

function testIsMaxLevel() public {
  LibExperience.initExp(targetEntity);
  // assertFalse(LibExperience.isMaxLevel(targetEntity));

  // Set the experience to the maximum level
  uint32[PStat_length] memory maxExp = [uint32(type(uint8).max), type(uint8).max, type(uint8).max];
  Experience.set(targetEntity, maxExp);

  assertLe(LibExperience.getAggregateLevel(targetEntity, maxExp), 16);
}

}