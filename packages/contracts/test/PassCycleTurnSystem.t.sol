// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { MudLibTest } from "./MudLibTest.t.sol";
import { PassCycleTurnSystem } from "../src/cycle/PassCycleTurnSystem.sol";
import { LibCycle } from "../src/cycle/LibCycle.sol";
import { LibCycleTurns } from "../src/cycle/LibCycleTurns.sol";
import { LibCharstat } from "../src/charstat/LibCharstat.sol";
import { ActiveCycle, CycleTurns, ActiveCombat } from "../src/codegen/index.sol";

contract PassCycleTurnSystemTest is MudLibTest {
  bytes32 internal wandererEntity = keccak256("wandererEntity");
  bytes32 internal cycleEntity;
  PassCycleTurnSystem internal passCycleTurnSystem;

  function setUp() public {
    passCycleTurnSystem = new PassCycleTurnSystem();
    cycleEntity = LibCycle.initCycle(wandererEntity, keccak256("guiseProtoEntity"), keccak256("wheelEntity"));
  }

  function testPassCycle() public {
    bytes memory args = abi.encode(wandererEntity);
    passCycleTurnSystem.passCycle(args);

    uint32 turns = CycleTurns.get(cycleEntity);
    assertEq(turns, LibCycleTurns.TURNS_PER_PERIOD - 1);
  }

  function testPassCycle_RevertIfActiveCombat() public {
    ActiveCombat.set(cycleEntity, true); // Simulate active combat
    bytes memory args = abi.encode(wandererEntity);
    vm.expectRevert();
    passCycleTurnSystem.passCycle(args);
  }
}
