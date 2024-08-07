// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { MudLibTest } from "./MudLibTest.t.sol";
import { StartCycleSystem } from "../src/cycle/StartCycleSystem.sol";
import { LibCycle } from "../src/cycle/LibCycle.sol";

import { ActiveGuise, ActiveWheel, PreviousCycle, Wheel, WheelData, GuisePrototype, ActiveCycle, CycleToWanderer } from "../src/codegen/index.sol";

contract StartCycleSystemTest is MudLibTest {
  bytes32 internal wandererEntity = keccak256("wandererEntity");
  bytes32 internal guiseProtoEntity = keccak256("guiseProtoEntity");
  bytes32 internal wheelEntity = keccak256("wheelEntity");
  StartCycleSystem internal startCycleSystem;

  function setUp() public virtual override {
    startCycleSystem = new StartCycleSystem();
  }

  function testStartCycle() public {
    bytes32 cycleEntity = startCycleSystem.startCycle(wandererEntity, guiseProtoEntity, wheelEntity);
    assertEq(cycleEntity, ActiveCycle.get(wandererEntity));
  }

  function testStartCycle_RevertIfCycleAlreadyActive() public {
    startCycleSystem.startCycle(wandererEntity, guiseProtoEntity, wheelEntity);
    vm.expectRevert(LibCycle.LibCycle_CycleIsAlreadyActive.selector);
    startCycleSystem.startCycle(wandererEntity, guiseProtoEntity, wheelEntity);
  }
}
