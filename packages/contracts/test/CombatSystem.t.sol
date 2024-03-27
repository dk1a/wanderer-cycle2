// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { MudLibTest } from "./MudLibTest.t.sol";

import { ActiveCombat } from "../src/codegen/index.sol";
import { CombatSystem, CombatAction, CombatActionType } from "../src/combat/CombatSystem.sol";
import { LibActiveCombat } from "../src/combat/LibActiveCombat.sol";
import { LibCharstat } from "../src/charstat/LibCharstat.sol";
import { CombatResult, PStat, PStat_length, EleStat_length } from "../src/CustomTypes.sol";
import { StatmodTopics } from "../src/modules/statmod/StatmodTopic.sol";
import { Statmod } from "../src/modules/statmod/Statmod.sol";
import { EleStat, StatmodOp } from "../src/codegen/common.sol";

contract CombatSystemTest is MudLibTest {
  address writer = address(bytes20(keccak256("writer")));
  bytes32 userEntity = keccak256("userEntity");
  bytes32 playerEntity = keccak256("playerEntity");
  bytes32 encounterEntity = keccak256("encounterEntity");

  CombatAction[] _noActions;

  // default data
  uint32 constant initLevel = 2;
  uint32 initLife;
  uint32 initAttack;
  uint32 maxRounds = 12;

  // statmod proto entities
  bytes32 levelPE = StatmodTopics.LEVEL.toStatmodEntity(StatmodOp.BADD, EleStat.NONE);

  function setUp() public virtual override {
    super.setUp();

    // authorize writer
    _grantRootAccess(writer);

    // give direct levels
    // (note: don't change statmods directly outside of tests, use effects)
    Statmod.increase(playerEntity, levelPE, initLevel);
    Statmod.increase(encounterEntity, levelPE, initLevel);

    // initialize and fill up life, mana
    LibCharstat.setFullCurrents(playerEntity);
    LibCharstat.setFullCurrents(encounterEntity);

    // activate combat between player and encounter
    world.executeActivateCombat(playerEntity, encounterEntity, maxRounds);

    initLife = LibCharstat.getLifeCurrent(playerEntity);
    initAttack = LibCharstat.getAttack(playerEntity)[uint256(EleStat.PHYSICAL)];
  }

  // ================ HELPERS ================

  function _sumElements(uint32[EleStat_length] memory elemValues) internal pure returns (uint32 result) {
    // TODO elemental values could use their own library, or at least some helpers
    for (uint256 i = 1; i < EleStat_length; i++) {
      result += elemValues[i];
    }
  }

  function _actions1Attack() internal pure returns (CombatAction[] memory result) {
    result = new CombatAction[](1);
    result[0] = CombatAction({ actionType: CombatActionType.ATTACK, actionEntity: 0 });
  }

  function _actions2Attacks() internal pure returns (CombatAction[] memory result) {
    result = new CombatAction[](2);
    result[0] = CombatAction({ actionType: CombatActionType.ATTACK, actionEntity: 0 });
    result[1] = CombatAction({ actionType: CombatActionType.ATTACK, actionEntity: 0 });
  }

  // ================ TESTS ================

  // this just shows the values I expect, and may need to change if LibCharstat config changes
  function test_setUp() public {
    assertEq(initLife, 2 + 2 * initLevel);
    assertEq(LibCharstat.getLifeCurrent(playerEntity), LibCharstat.getLifeCurrent(encounterEntity));

    assertEq(initAttack, 1 + initLevel / 2);
    assertEq(_sumElements(LibCharstat.getAttack(playerEntity)), initAttack);
    assertEq(_sumElements(LibCharstat.getAttack(playerEntity)), _sumElements(LibCharstat.getAttack(encounterEntity)));
  }

  function test_combatPVERound_notWriter() public {
    vm.prank(address(bytes20(keccak256("notWriter"))));
    // vm.expectRevert(OwnableWritable.OwnableWritable__NotWriter.selector);
    world.executePVERound(userEntity, playerEntity, encounterEntity, _noActions, _noActions);
  }

  // skipping a round is fine
  function test_combatPVERound_noActions() public {
    vm.prank(writer);
    CombatResult result = world.executePVERound(userEntity, playerEntity, encounterEntity, _noActions, _noActions);
    assertEq(uint8(result), uint8(CombatResult.NONE));
  }

  // by default entities can only do 1 action per round
  function test_combatPVERound_invalidActionsLength() public {
    vm.prank(writer);
    vm.expectRevert(CombatSystem.CombatSystem_InvalidActionsLength.selector);
    world.executePVERound(userEntity, playerEntity, encounterEntity, _actions2Attacks(), _actions2Attacks());
  }

  // an unopposed single attack
  function test_combatPVERound_playerAttacks_1() public {
    vm.prank(writer);

    CombatResult result = world.executePVERound(
      userEntity,
      playerEntity,
      encounterEntity,
      _actions1Attack(),
      _noActions
    );
    assertEq(uint8(result), uint8(CombatResult.NONE));
    assertEq(LibCharstat.getLifeCurrent(encounterEntity), initLife - initAttack);
  }

  // unopposed player attacks, enough to get victory
  function test_combatPVERound_playerAttacks_victory() public {
    vm.prank(writer);

    CombatResult result;
    // do enough attacks to defeat encounter
    uint256 attacksNumber = initLife / initAttack;
    for (uint256 i; i < attacksNumber; i++) {
      result = world.executePVERound(userEntity, playerEntity, encounterEntity, _actions1Attack(), _noActions);
      if (i != attacksNumber - 1) {
        assertEq(uint8(result), uint8(CombatResult.NONE));
      }
    }
    assertEq(uint8(result), uint8(CombatResult.VICTORY));
    assertEq(LibCharstat.getLifeCurrent(encounterEntity), 0);
  }

  // unopposed encounter attacks, enough to get defeat
  function test_combatPVERound_encounterAttacks_defeat() public {
    vm.prank(writer);

    CombatResult result;
    // do enough attacks to defeat player
    uint256 attacksNumber = initLife / initAttack;
    for (uint256 i; i < attacksNumber; i++) {
      result = world.executePVERound(userEntity, playerEntity, encounterEntity, _noActions, _actions1Attack());
      if (i != attacksNumber - 1) {
        assertEq(uint8(result), uint8(CombatResult.NONE));
      }
    }
    assertEq(uint8(result), uint8(CombatResult.DEFEAT));
    assertEq(LibCharstat.getLifeCurrent(playerEntity), 0);
  }

  // player and encounter have the same stats and attacks, but player goes 1st and wins the last round
  function test_combatPVERound_opposedAttacks_victoryByInitiative() public {
    vm.prank(writer);

    CombatResult result;
    // do enough attacks to defeat encounter
    uint256 attacksNumber = initLife / initAttack;
    for (uint256 i; i < attacksNumber; i++) {
      result = world.executePVERound(userEntity, playerEntity, encounterEntity, _actions1Attack(), _actions1Attack());
      if (i != attacksNumber - 1) {
        assertEq(uint8(result), uint8(CombatResult.NONE));
      }
    }
    assertEq(uint8(result), uint8(CombatResult.VICTORY));
    // also check that the last encounter action didn't go through, since it lost
    assertEq(LibCharstat.getLifeCurrent(playerEntity), initLife - initAttack * (attacksNumber - 1));
    assertEq(LibCharstat.getLifeCurrent(encounterEntity), 0);
  }

  function testRoundDurationDecrease() public {
    //Initialization and activation of combat
    world.executeActivateCombat(playerEntity, encounterEntity, maxRounds);

    uint32 initialRoundsMax = ActiveCombat.getRoundsMax(playerEntity);

    vm.prank(writer);
    world.executePVERound(userEntity, playerEntity, encounterEntity, _noActions, _noActions);

    uint32 roundsAfterOneFight = ActiveCombat.getRoundsMax(playerEntity);
    assertEq(initialRoundsMax - 1, roundsAfterOneFight, "Round duration should decrease by 1");
  }

  function testCombatDeactivatesAfterMaxRounds() public {
    uint32 oneRound = 1;
    world.executeActivateCombat(playerEntity, encounterEntity, oneRound);

    vm.prank(writer);
    world.executePVERound(userEntity, playerEntity, encounterEntity, _noActions, _noActions);

    bool isActive = ActiveCombat.getRetaliatorEntity(playerEntity) != bytes32(0);
    assertFalse(isActive, "Combat should be deactivated after max rounds");
  }

  function testInvalidActionsLength() public {
    CombatAction[] memory actions = _actions2Attacks();

    vm.prank(writer);
    vm.expectRevert(CombatSystem.CombatSystem_InvalidActionsLength.selector);
    world.executePVERound(userEntity, playerEntity, encounterEntity, actions, _noActions);
  }

  // TODO So far just basic physical attacks. More tests, with statmods and skills.
}
