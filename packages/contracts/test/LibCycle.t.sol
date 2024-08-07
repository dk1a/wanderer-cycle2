// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { MudLibTest } from "./MudLibTest.t.sol";
import { LibCycle } from "../src/cycle/LibCycle.sol";

import { ActiveGuise, ActiveWheel, PreviousCycle, Wheel, WheelData, GuisePrototype, ActiveCycle, CycleToWanderer } from "../src/codegen/index.sol";
import { ICycleInitSystem } from "../src/codegen/world/ICycleInitSystem.sol";

import { LibCharstat } from "../src/charstat/LibCharstat.sol";
import { LibExperience } from "../src/charstat/LibExperience.sol";
import { LibCycleTurns } from "./src/cycle/LibCycleTurns.sol";
import { LibCycle } from "./src/cycle/LibCycle.sol";
import { LibLearnedSkills } from "../src/skill/LibLearnedSkills.sol";

contract LibCycleTest is MudLibTest {
  bytes32 internal wandererEntity = keccak256("wandererEntity");
  bytes32 internal guiseProtoEntity = keccak256("guiseProtoEntity");
  bytes32 internal wheelEntity = keccak256("wheelEntity");
  bytes32 internal cycleEntity;

  function setUp() public {
    // Set up initial state
    cycleEntity = LibCycle.initCycle(wandererEntity, guiseProtoEntity, wheelEntity);
  }

  function testInitCycle() public {
    assertEq(cycleEntity, ActiveCycle.get(wandererEntity));
  }

  function testInitCycle_RevertIfCycleAlreadyActive() public {
    // Trying to initialize a cycle when one is already active should revert
    vm.expectRevert(LibCycle.LibCycle_CycleIsAlreadyActive.selector);
    LibCycle.initCycle(wandererEntity, guiseProtoEntity, wheelEntity);
  }

  function testEndCycle() public {
    LibCycle.endCycle(wandererEntity, cycleEntity);
    assertEq(ActiveCycle.get(wandererEntity), bytes32(0));
    assertEq(CycleToWanderer.get(cycleEntity), bytes32(0));
  }

  function testGetCycleEntityPermissioned() public {
    bytes32 retrievedCycleEntity = LibCycle.getCycleEntityPermissioned(wandererEntity);
    assertEq(retrievedCycleEntity, cycleEntity);
  }

  function testGetCycleEntityPermissioned_RevertIfNotActive() public {
    LibCycle.endCycle(wandererEntity, cycleEntity);
    vm.expectRevert(LibCycle.LibCycle_CycleNotActive.selector);
    LibCycle.getCycleEntityPermissioned(wandererEntity);
  }
}
