// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { MudLibTest } from "./MudLibTest.t.sol";
import { getUniqueEntity } from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";
import { hasKey } from "@latticexyz/world-modules/src/modules/keysintable/hasKey.sol";
import { IERC721Mintable } from "@latticexyz/world-modules/src/modules/erc721-puppet/IERC721Mintable.sol";
import { IWorld } from "../src/codegen/world/IWorld.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";

import { ROOT_NAMESPACE_ID } from "@latticexyz/world/src/constants.sol";
import { NamespaceOwner } from "@latticexyz/world/src/codegen/tables/NamespaceOwner.sol";

import { ActiveGuise, DefaultWheel, Wanderer, GuisePrototype, ActiveCycle, CycleTurns, LifeCurrent, ManaCurrent, GameConfig } from "../src/codegen/index.sol";

import { LibCycle } from "../src/cycle/LibCycle.sol";
import { LibGuise } from "../src/guise/LibGuise.sol";
import { LibExperience } from "../src/charstat/LibExperience.sol";
import { LibToken } from "../src/wnft/LibToken.sol";
//import { IERC721BaseInternal } from "@latticexyz/world-modules/src/modules/erc721-puppet/IERC721BaseInternal.sol";

contract WandererSpawnTest is MudLibTest {
  bytes32 guiseEntity;
  bytes32 wandererEntity;
  bytes32 cycleEntity;
  bytes32 defaultWheelEntity;
  uint256 badGoatToken;
  uint256 beefToken;
  address alice;
  address badGuy;

  function setUp() public virtual override {
    super.setUp();
    uint256 badGoatToken = uint256(0xBAD060A7);
    uint256 beefToken = uint256(0xBEEF);
    address alice = address(0x600D);
    address badGuy = address(0x0BAD);

    guiseEntity = LibGuise.getGuiseEntity("Warrior");

    // wandererEntity has all the permanent player data (not related to a specific cycle)
    (wandererEntity, cycleEntity) = world.spawnWanderer(guiseEntity);
    defaultWheelEntity = DefaultWheel.get();
  }

  function test_setUp_invalidGuise() public {
    vm.expectRevert(LibCycle.LibCycle_InvalidGuiseProtoEntity.selector);
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

  function test_tokenOwner() public {
    address expectedOwner = NamespaceOwner.get(ROOT_NAMESPACE_ID);
    assertEq(LibToken.ownerOf(), expectedOwner);
  }

  function test_tokenOwner_incorrectAddress() public {
    address tokenAddress = GameConfig.getTokenAddress();
    vm.expectRevert();
    LibToken.requireOwner(tokenAddress);
  }

  function test_activeGuise() public {
    assertEq(ActiveGuise.get(cycleEntity), guiseEntity);
    assertEq(ActiveGuise.get(wandererEntity), bytes32(0));
  }

  function test_experience() public {
    assertTrue(LibExperience.hasExp(cycleEntity));
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
