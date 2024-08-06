// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { System } from "@latticexyz/world/src/System.sol";

import { ActiveGuise, SkillTemplate, SkillTemplateData, GuiseSkill } from "../codegen/index.sol";

import { LibLearnedSkills } from "../skill/LibLearnedSkills.sol";
import { LibCycle } from "./LibCycle.sol";
import { LibGuiseLevel } from "../guise/LibGuiseLevel.sol";

/// @title Learn a Skill from the current cycle Guise's set of available skills.
contract LearnCycleSkillSystem is System {
  error LearnCycleSkillSystem__SkillNotInGuiseSkills();
  error LearnCycleSkillSystem__LevelIsTooLow();

  function learnFromCycle(bytes memory args) public override returns (bytes memory) {
    (bytes32 wandererEntity, bytes32 skillEntity) = abi.decode(args, (bytes32, bytes32));

    // get cycle entity if sender is allowed to use it
    bytes32 cycleEntity = LibCycle.getCycleEntityPermissioned(wandererEntity);

    // check skill's level requirements
    uint32 currentLevel = LibGuiseLevel.getAggregateLevel(cycleEntity);
    uint8 requiredLevel = SkillTemplate.getRequiredLevel(skillEntity);
    if (currentLevel < requiredLevel) {
      revert LearnCycleSkillSystem__LevelIsTooLow();
    }

    // guise skills must include `skillEntity`
    bytes32 guiseProtoEntity = ActiveGuise.get(cycleEntity);
    bytes32[] skills = GuiseSkill.get(guiseProtoEntity);

    bool res = false;
    for (uint i = 0; i < skills.length; i++) {
      if (skills[i] == skillEntity) {
        res = true;
        break;
      }
    }

    if (!res) {
      revert LearnCycleSkillSystem__SkillNotInGuiseSkills();
    }
    // learn the skill
    LibLearnedSkills.learnSkill(wandererEntity, skillEntity);

    return "";
  }
}
