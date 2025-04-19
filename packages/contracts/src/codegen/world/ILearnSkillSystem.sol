// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

/**
 * @title ILearnSkillSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface ILearnSkillSystem {
  error LearnSkillSystem_LearnSkillDuplicate();

  function skill__learnSkill(bytes32 userEntity, bytes32 skillEntity) external;

  function skill__copySkills(bytes32 sourceEntity, bytes32 targetEntity) external;
}
