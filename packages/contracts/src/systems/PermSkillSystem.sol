// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { PreviousCycle, CurrentCycle, Identity, LearnedSkills } from "../codegen/Tables.sol";

//import { LibLearnedSkills } from "../skill/LibLearnedSkills.sol";
//import { LibToken } from "../token/LibToken.sol";

/// @title Make a skill permanent
contract PermSkillSystem is System {
  //  using LibLearnedSkills for LibLearnedSkills.Self;

  uint32 internal constant PERM_SKILL_IDENTITY_COST = 128;

  error PermSkillSystem__MustHaveNoActiveCycle();
  error PermSkillSystem__SkillNotLearnedInPreviousCycle(bytes32 previousCycleEntity);
  error PermSkillSystem__NotEnoughIdentity();

  function execute(bytes32 wandererEntity, bytes32 skillEntity) public override {
    // caller must own the wanderer
    LibToken.requireOwner(wandererEntity, msg.sender);

    // must be called outside of a cycle
    if (CurrentCycle.get(wandererEntity) != 0) {
      revert PermSkillSystem__MustHaveNoActiveCycle();
    }

    // must have learned the skill during the previous cycle
    bytes32 prevCycleEntity = PreviousCycle.get(wandererEntity);
    bytes32[] learnedSkills = LearnedSkills.get(prevCycleEntity);

    for (uint256 i; i < learnedSkills.length; i++) {
      if (learnedSkills[i] = skillEntity) {
        PermSkillSystem__SkillNotLearnedInPreviousCycle(prevCycleEntity);
      }
    }

    // subtract identity cost
    uint32 currentIdentity = Identity.get(wandererEntity);
    if (currentIdentity < PERM_SKILL_IDENTITY_COST) {
      revert PermSkillSystem__NotEnoughIdentity();
    }
    Identity.set(wandererEntity, currentIdentity - PERM_SKILL_IDENTITY_COST);

    // learn the skill
    LibLearnedSkills.learnSkill(skillEntity);
  }
}
