// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { hasKey } from "@latticexyz/world-modules/src/modules/keysintable/hasKey.sol";

import { LearnedSkills, SkillTemplate, SkillTemplateData } from "../codegen/index.sol";
import { TargetType, SkillType } from "../../../codegen/common.sol";

import { LibSkill } from "./LibSkill.sol";

library LibLearnedSkills {
  error LibLearnedSkills__LearnSkillDuplicate();

  function hasSkill(bytes32 userEntity, bytes32 skillEntity) internal view returns (bool) {
    bytes32[] memory userSkills = LearnedSkills.get(userEntity);
    for (uint256 i = 0; i < userSkills.length; i++) {
      if (userSkills[i] == skillEntity) {
        return true;
      }
    }
    return false;
  }

  /**
   * @dev Add `skillEntity` to set of learned skills, revert if it's already learned
   */
  function learnSkill(bytes32 userEntity, bytes32 skillEntity) internal {
    bytes32[] memory userSkills = LearnedSkills.get(userEntity);
    for (uint256 i = 0; i < userSkills.length; i++) {
      if (userSkills[i] == skillEntity) {
        revert LibLearnedSkills__LearnSkillDuplicate();
      }
    }
    LearnedSkills.push(userEntity, skillEntity);
    _autotoggleIfPassive(userEntity, skillEntity);
  }

  /**
   * @dev Copy skills from source to target. Overwrites target's existing skills
   */
  function copySkills(bytes32 sourceEntity, bytes32 targetEntity) internal {
    bool isKey = hasKey(LearnedSkills._tableId, LearnedSkills.encodeKeyTuple(targetEntity));
    if (isKey) {
      bytes32[] memory skillEntities = LearnedSkills.get(targetEntity);
      LearnedSkills.set(sourceEntity, skillEntities);

      for (uint256 i; i < skillEntities.length; i++) {
        _autotoggleIfPassive(sourceEntity, skillEntities[i]);
      }
    }
  }

  function _autotoggleIfPassive(bytes32 userEntity, bytes32 skillEntity) private {
    SkillType skillType = SkillTemplate.getSkillType(skillEntity);
    if (skillType == SkillType.PASSIVE) {
      LibSkill.useSkill(userEntity, skillEntity, userEntity);
    }
  }
}
