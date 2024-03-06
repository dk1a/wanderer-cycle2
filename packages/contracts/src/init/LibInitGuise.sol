// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { getUniqueEntity } from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";

import { GuisePrototype, Name } from "../codegen/index.sol";
import { PStat_length } from "../CustomTypes.sol";

import { LibSkill as ls } from "../skill/LibSkill.sol";

library LibInitGuise {
  function init() internal {
    // TODO maybe move guise skills init to LibInitSkill and have it depend on guise instead?
    bytes32[] memory guiseSkills = new bytes32[](3);
    guiseSkills[0] = ls.getSkillEntity("Cleave");
    guiseSkills[1] = ls.getSkillEntity("Charge");
    guiseSkills[2] = ls.getSkillEntity("Parry");

    add("Warrior", [uint32(16), 8, 8], guiseSkills);
  }

  function add(string memory name, uint32[PStat_length] memory pstat, bytes32[] memory guiseSkills) internal {
    bytes32 entity = getUniqueEntity();

    GuisePrototype.set(entity, pstat);
    Name.set(entity, name);
    // guiseSkillsComp.set(entity, guiseSkills);
  }
}