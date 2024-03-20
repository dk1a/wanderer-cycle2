// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { MudLibTest } from "./MudLibTest.t.sol";

import { CombatSystem, Action, ActionType } from "../src/combat/CombatSystem.sol";
import { LibActiveCombat } from "../src/combat/LibActiveCombat.sol";
import { LibCharstat } from "../src/charstat/LibCharstat.sol";
import { PStat, PStat_length, EleStat_length } from "../src/CustomTypes.sol";
import { StatmodTopics } from "../src/modules/statmod/StatmodTopic.sol";
import { Statmod } from "../src/modules/statmod/Statmod.sol";
import { EleStat, StatmodOp } from "../src/codegen/common.sol";

contract CombatSystemTest is MudLibTest {
  address writer = address(bytes20(keccak256("writer")));
  bytes32 userEntity = keccak256("userEntity");
  bytes32 playerEntity = keccak256("playerEntity");
  bytes32 encounterEntity = keccak256("encounterEntity");

  Action[] _noActions;

  // default data
  uint32 constant initLevel = 2;
  uint32 initLife;
  uint32 initAttack;
  uint256 maxRounds = 12;

  // statmod proto entities
  bytes32 levelPE = StatmodTopics.LEVEL.toStatmodEntity(StatmodOp.BADD, EleStat.NONE);

  function setUp() public virtual override {
    super.setUp();

    // authorize writer
    CombatSystem.authorizeWriter(writer);

    // give direct levels
    // (note: don't change statmods directly outside of tests, use effects)
    Statmod.increase(playerEntity, levelPE, initLevel);
    Statmod.increase(encounterEntity, levelPE, initLevel);

    // initialize and fill up life, mana
    LibCharstat.setFullCurrents(playerEntity);
    LibCharstat.setFullCurrents(encounterEntity);

    // activate combat between player and encounter
    CombatSystem.executeActivateCombat(playerEntity, encounterEntity, maxRounds);

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

  function _actions1Attack() internal pure returns (Action[] memory result) {
    result = new Action[](1);
    result[0] = Action({ actionType: ActionType.ATTACK, actionEntity: 0 });
  }

  function _actions2Attacks() internal pure returns (Action[] memory result) {
    result = new Action[](2);
    result[0] = Action({ actionType: ActionType.ATTACK, actionEntity: 0 });
    result[1] = Action({ actionType: ActionType.ATTACK, actionEntity: 0 });
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
    CombatSystem.executePVERound(userEntity, playerEntity, encounterEntity, _noActions, _noActions);
  }

  // skipping a round is fine
  function test_combatPVERound_noActions() public {
    vm.prank(writer);
    CombatSystem.CombatResult result = CombatSystem.executePVERound(
      userEntity,
      playerEntity,
      encounterEntity,
      _noActions,
      _noActions
    );
    assertEq(uint8(result), uint8(CombatSystem.CombatResult.NONE));
  }

  // by default entities can only do 1 action per round
  function test_combatPVERound_invalidActionsLength() public {
    vm.prank(writer);
    vm.expectRevert(CombatSystem.CombatSystem__InvalidActionsLength.selector);
    CombatSystem.executePVERound(userEntity, playerEntity, encounterEntity, _actions2Attacks(), _actions2Attacks());
  }

  // an unopposed single attack
  function test_combatPVERound_playerAttacks_1() public {
    vm.prank(writer);

    CombatSystem.CombatResult result = combatSubSystem.executePVERound(
      userEntity,
      playerEntity,
      encounterEntity,
      _actions1Attack(),
      _noActions
    );
    assertEq(uint8(result), uint8(CombatSystem.CombatResult.NONE));
    assertEq(LibCharstat.getLifeCurrent(encounterEntity), initLife - initAttack);
  }

  // unopposed player attacks, enough to get victory
  function test_combatPVERound_playerAttacks_victory() public {
    vm.prank(writer);

    CombatSystem.CombatResult result;
    // do enough attacks to defeat encounter
    uint256 attacksNumber = initLife / initAttack;
    for (uint256 i; i < attacksNumber; i++) {
      result = CombatSystem.executePVERound(userEntity, playerEntity, encounterEntity, _actions1Attack(), _noActions);
      if (i != attacksNumber - 1) {
        assertEq(uint8(result), uint8(CombatSystem.CombatResult.NONE));
      }
    }
    assertEq(uint8(result), uint8(CombatSystem.CombatResult.VICTORY));
    assertEq(LibCharstat.getLifeCurrent(encounterEntity), 0);
  }

  // unopposed encounter attacks, enough to get defeat
  function test_combatPVERound_encounterAttacks_defeat() public {
    vm.prank(writer);

    CombatSystem.CombatResult result;
    // do enough attacks to defeat player
    uint256 attacksNumber = initLife / initAttack;
    for (uint256 i; i < attacksNumber; i++) {
      result = CombatSystem.executePVERound(userEntity, playerEntity, encounterEntity, _noActions, _actions1Attack());
      if (i != attacksNumber - 1) {
        assertEq(uint8(result), uint8(CombatSystem.CombatResult.NONE));
      }
    }
    assertEq(uint8(result), uint8(CombatSystem.CombatResult.DEFEAT));
    assertEq(LibCharstat.getLifeCurrent(playerEntity), 0);
  }

  // player and encounter have the same stats and attacks, but player goes 1st and wins the last round
  function test_combatPVERound_opposedAttacks_victoryByInitiative() public {
    vm.prank(writer);

    CombatSystem.CombatResult result;
    // do enough attacks to defeat encounter
    uint256 attacksNumber = initLife / initAttack;
    for (uint256 i; i < attacksNumber; i++) {
      result = CombatSystem.executePVERound(
        userEntity,
        playerEntity,
        encounterEntity,
        _actions1Attack(),
        _actions1Attack()
      );
      if (i != attacksNumber - 1) {
        assertEq(uint8(result), uint8(CombatSystem.CombatResult.NONE));
      }
    }
    assertEq(uint8(result), uint8(CombatSystem.CombatResult.VICTORY));
    // also check that the last encounter action didn't go through, since it lost
    assertEq(LibCharstat.getLifeCurrent(playerEntity), initLife - initAttack * (attacksNumber - 1));
    assertEq(LibCharstat.getLifeCurrent(encounterEntity), 0);
  }

  // TODO So far just basic physical attacks. More tests, with statmods and skills.
}
