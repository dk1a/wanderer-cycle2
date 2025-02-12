// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { MudLibTest } from "./MudLibTest.t.sol";
import { CycleTurns } from "../src/namespaces/root/codegen/index.sol";

import { LibGuise } from "../src/namespaces/root/guise/LibGuise.sol";
import { LibCycle } from "../src/namespaces/root/cycle/LibCycle.sol";
import { LibCycleTurns } from "../src/namespaces/root/cycle/LibCycleTurns.sol";

contract PassCycleTurnSystemTest is MudLibTest {
  bytes32 internal guiseEntity;
  bytes32 internal wandererEntity;
  bytes32 internal cycleEntity;

  function setUp() public virtual override {
    super.setUp();

    guiseEntity = LibGuise.getGuiseEntity("Warrior");
    (wandererEntity, cycleEntity) = world.spawnWanderer(guiseEntity);
  }

  function testPassCycleTurn() public {
    world.passCycleTurn(wandererEntity);

    uint32 turns = CycleTurns.get(cycleEntity);
    assertEq(turns, LibCycleTurns.TURNS_PER_PERIOD - 1);
  }

  function testPassAllTurns() public {
    // Pass all available turns
    for (uint i = 0; i < LibCycleTurns.TURNS_PER_PERIOD; i++) {
      world.passCycleTurn(wandererEntity);
    }

    uint32 turns = CycleTurns.get(cycleEntity);
    assertEq(turns, 0, "All turns should be used up");
  }
}
