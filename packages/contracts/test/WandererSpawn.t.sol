// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { MudLibTest } from "./MudLibTest.t.sol";
import { getUniqueEntity } from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";
import { hasKey } from "@latticexyz/world-modules/src/modules/keysintable/hasKey.sol";

import { ActiveGuise, DefaultWheel, Wanderer, GuisePrototype, ActiveCycle, CycleTurns, LifeCurrent, ManaCurrent } from "../src/codegen/index.sol";

import { LibCycle } from "../src/cycle/LibCycle.sol";
import { LibExperience } from "../src/charstat/LibExperience.sol";

contract WandererSpawnTest is MudLibTest {
  // TODO replace with an actual guise entity
  bytes32 guiseEntity = keccak256("Warrior");

  bytes32 wandererEntity;
  bytes32 cycleEntity;
  bytes32 defaultWheelEntity;

  function setUp() public virtual override {
    super.setUp();

    // wandererEntity has all the permanent player data (not related to a specific cycle)
    (wandererEntity, cycleEntity) = world.spawnWanderer(guiseEntity);
    defaultWheelEntity = DefaultWheel.get();
  }

  function test_setUp_invalidGuise() public {
    vm.expectRevert(LibCycle.LibCycle__InvalidGuiseProtoEntity.selector);
    world.spawnWanderer(keccak256("invalid guise"));
  }

  function test_initCycle_another() public {
    // initializing a cycle for some unrelated entity should work fine and produce an unrelated cycleEntity
    bytes32 anotherCycleEntity = LibCycle.initCycle(getUniqueEntity(), guiseEntity, defaultWheelEntity);
    assertNotEq(anotherCycleEntity, cycleEntity);
  }

  function test_entities() public {
    assertNotEq(cycleEntity, wandererEntity);
    assertNotEq(cycleEntity, 0);
  }

  function test_wanderer() public {
    assertTrue(Wanderer.get(wandererEntity));
  }

  /*TODO tokens
  function test_tokenOwner() public {
    assertEq(wNFTSystem.ownerOf(wandererEntity), alice);
  }

  function test_tokenOwner_notForCycleEntity() public {
    // cycleEntity shouldn't even be a token, this error refers to address(0)
    vm.expectRevert(IERC721BaseInternal.ERC721Base__InvalidOwner.selector);
    wNFTSystem.ownerOf(cycleEntity);
  }*/

  function test_activeGuise() public {
    assertEq(ActiveGuise.get(cycleEntity), guiseEntity);
    assertEq(ActiveGuise.get(wandererEntity), bytes32(0));
  }

  function test_experience() public {
    assertTrue(LibExperience.hasExp(cycleEntity));
    // TODO wandererEntity could have exp for some non-cycle-related reasons, come back to this later
    // TODO (same thing with currents, though less likely)
    assertFalse(LibExperience.hasExp(wandererEntity));
  }

  function test_currents() public {
    assertGt(LifeCurrent.get(cycleEntity), 0);
    assertGt(ManaCurrent.get(cycleEntity), 0);
  }

  function test_cycleTurns() public {
    assertGt(CycleTurns.getValue(cycleEntity), 0);
  }
}
