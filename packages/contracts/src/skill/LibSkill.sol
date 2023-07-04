// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { LibCharstat } from "../charstat/LibCharstat.sol";
import { LibLearnedSkills } from "./LibLearnedSkills.sol";

import { LearnedSkills, SkillTemplate, SkillTemplateData, EffectTemplate, EffectTemplateData } from "../codegen/Tables.sol";
import { SkillType, TargetType, EffectRemovabilityId } from "../codegen/Types.sol";

//import { DurationSubSystem, ScopedDuration, SystemCallback } from ;
//import { EffectSubSystem } from ;

library LibSkill {
  //  using LibCharstat for LibCharstat.Self;
  //  using LibLearnedSkills for LibLearnedSkills.Self;

  error LibSkill__SkillMustBeLearned();
  error LibSkill__SkillOnCooldown();
  error LibSkill__NotEnoughMana();
  error LibSkill__InvalidSkillTarget();
  error LibSkill__RequiredCombat();
  error LibSkill__RequiredNonCombat();

  struct Self {
    LibCharstat.Self charstat;
    LibLearnedSkills.Self learnedSkills;
    uint256 userEntity;
    uint256 skillEntity;
    SkillPrototype skill;
  }

  function switchSkill(
    bytes32 skillEntity,
    bytes32 skillEntity
  ) internal view returns (SkillTemplateData memory skill) {
    SkillTemplateData skill = SkillTemplate.get(skillEntity);
    return skill;
  }

  function requireCombat(SkillTemplateData memory skill) internal pure {
    if (SkillTemplateData.skillType != SkillType.COMBAT) {
      revert LibSkill__RequiredCombat();
    }
  }

  function requireNonCombat(SkillTemplateData memory skill) internal pure {
    if (SkillTemplateData.skillType == SkillType.COMBAT) {
      revert LibSkill__RequiredNonCombat();
    }
  }

  /**
   * @dev Combat skills may target either self or enemy, depending on skill prototype
   */
  function chooseCombatTarget(
    SkillTemplateData memory skill,
    bytes32 enemyEntity,
    bytes32 userEntity
  ) internal pure returns (bytes32) {
    if (skill.targetType == TargetType.SELF || skill.targetType == TargetType.SELF_OR_ALLY) {
      return userEntity;
    } else if (skill.targetType == TargetType.ENEMY) {
      return enemyEntity;
    } else {
      revert LibSkill__InvalidSkillTarget();
    }
  }

  /**
   * @dev Check some requirements, subtract cost, start cooldown, apply effect.
   * However this method is NOT combat aware and doesn't do attack/spell damage
   */
  function useSkill(
    SkillTemplateData memory skill,
    bytes32 skillEntity,
    bytes32 targetEntity,
    bytes32 userEntity
  ) internal {
    // must be learned
    if (LibLearnedSkills.hasSkill(skillEntity)) {
      revert LibSkill__SkillMustBeLearned();
    }
    // must be off cooldown
    //    DurationSubSystem durationSubSystem = DurationSubSystem(
    //      getAddressById(__self.world.systems(), DurationSubSystemID)
    //    );
    //    if (durationSubSystem.has(targetEntity, __self.skillEntity)) {
    //      revert LibSkill__SkillOnCooldown();
    //    }
    // verify self-only skill
    if (skill.targetType == TargetType.SELF && userEntity != targetEntity) {
      revert LibSkill__InvalidSkillTarget();
    }
    // TODO verify other target types?

    // start cooldown
    // (doesn't clash with skill effect duration, which has its own entity)
    //    if (skill.cooldown.timeValue > 0) {
    //      durationSubSystem.executeIncrease(targetEntity, __self.skillEntity, __self.skill.cooldown, SystemCallback(0, ""));
    //    }

    // check and subtract skill cost
    uint32 manaCurrent = LibCharstat.getManaCurrent();
    if (skill.cost > manaCurrent) {
      revert LibSkill__NotEnoughMana();
    } else if (skill.cost > 0) {
      LibCharstat.setManaCurrent(manaCurrent - skill.cost);
    }

    _applySkillEffect(__self, targetEntity);
  }

  function _applySkillEffect(SkillTemplateData memory skill, bytes32 targetEntity, bytes32 skillEntity) private {
    //    EffectSubSystem effectSubSystem = EffectSubSystem(getAddressById(__self.world.systems(), EffectSubSystemID));
    //
    //    if (!effectSubSystem.isEffectPrototype(skillEntity)) {
    //      // skip if skill has no effect
    //      return;
    //    }
    //
    //    if (skill.skillType == SkillType.PASSIVE) {
    //      // toggle passive skill
    //      if (effectSubSystem.has(targetEntity, skillEntity)) {
    //        effectSubSystem.executeRemove(targetEntity, skillEntity);
    //      } else {
    //        effectSubSystem.executeApply(targetEntity, skillEntity);
    //      }
    //    } else {
    //      // apply active skill
    //      effectSubSystem.executeApplyTimed(targetEntity, skillEntity, skill.duration);
    //    }
  }
}
