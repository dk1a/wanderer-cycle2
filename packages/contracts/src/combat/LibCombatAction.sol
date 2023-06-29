// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { ActionType } from "../codegen/Types.sol";

import { LibSkill } from "../skill/LibSkill.sol";
import { LibCharstat } from "../charstat/LibCharstat.sol";

uint256 constant EL_L = 5;

struct Action {
  ActionType actionType;
  bytes32 actionEntity;
}
struct ActorOpts {
  uint32 maxResistance;
}

library LibCombatAction {
  using LibCharstat for LibCharstat.Self;
  using LibSkill for LibSkill.Self;

  error LibCombat__InvalidActionType();

  struct Self {
    LibCharstat.Self attackerCharstat;
    ActorOpts attackerOpts;
    LibCharstat.Self defenderCharstat;
    ActorOpts defenderOpts;
  }

  function executeAction(Self memory __self, Action memory action) internal {
    if (action.actionType == ActionType.ATTACK) {
      // deal damage to defender (updates currents)
      _dealAttackDamage(__self);
    } else if (action.actionType == ActionType.SKILL) {
      _useSkill(__self, action.actionEntity);
    } else {
      revert LibCombat__InvalidActionType();
    }
  }

  function _useSkill(Self memory __self, bytes32 skillEntity) private {
    LibSkill.requireCombat();

    // combat skills may target either self or enemy, depending on skill prototype
    bytes32 targetEntity = LibSkill.chooseCombatTarget(__self.defenderCharstat.targetEntity);
    // use skill
    LibSkill.useSkill(targetEntity);

    // skill may need a follow-up attack and/or spell
    if (LibSkill.skill.withAttack) {
      _dealAttackDamage(__self);
    }
    if (LibSkill.skill.withSpell) {
      _dealSpellDamage(__self, LibSkill.skill.spellDamage);
    }
  }

  function _dealAttackDamage(Self memory __self) private {
    _dealDamage(__self, __self.attackerCharstat.getAttack());
  }

  function _dealSpellDamage(Self memory __self, uint32[EL_L] memory baseSpellDamage) private {
    _dealDamage(__self, __self.attackerCharstat.getSpell(baseSpellDamage));
  }

  /**
   * @dev Modifies LifeCurrent according to elemental damage and resistance
   * Resistances are percentages (scaling of 1/100)
   */
  function _dealDamage(Self memory __self, uint32[EL_L] memory elemDamage) private {
    uint32 maxResistance = __self.defenderOpts.maxResistance;
    assert(maxResistance <= 100);

    uint32[EL_L] memory resistance = __self.defenderCharstat.getResistance();

    // calculate total damage (elemental, 0 index isn't used)
    uint32 totalDamage = 0;
    for (uint256 i = 1; i < EL_L; i++) {
      uint32 elemResistance = resistance[i] < maxResistance ? resistance[i] : maxResistance;
      uint32 adjustedDamage = (elemDamage[i] * (100 - elemResistance)) / 100;
      totalDamage += adjustedDamage;
    }

    // modify life only if resistances didn't fully negate damage
    if (totalDamage == 0) return;

    // get life
    uint32 lifeCurrent = __self.defenderCharstat.getLifeCurrent();
    // subtract damage
    if (totalDamage >= lifeCurrent) {
      // life can't be negative
      lifeCurrent = 0;
    } else {
      lifeCurrent -= totalDamage;
    }
    // update life
    __self.defenderCharstat.setLifeCurrent(lifeCurrent);
  }
}
