// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";

import { Name, SkillTemplate, SkillTemplateData, GuisePrototype, AvailableSkills } from "../codegen/Tables.sol";
import { SkillType, TargetType } from ".../codegen/Types.sol";
import { PStat, PStat_length } from "../CustomTypes.sol";

library LibInitGuise {
  function init() internal {
    bytes32[] memory guiseSkills = new bytes32[](11);
    guiseSkills[0] = spe("Cleave");
    guiseSkills[1] = spe("Charge");
    guiseSkills[2] = spe("Parry");
    guiseSkills[3] = spe("Onslaught");
    guiseSkills[4] = spe("Toughness");
    guiseSkills[5] = spe("Thunder Clap");
    guiseSkills[6] = spe("Precise Strikes");
    guiseSkills[7] = spe("Blood Rage");
    guiseSkills[8] = spe("Retaliation");
    guiseSkills[9] = spe("Last Stand");
    guiseSkills[10] = spe("Weapon Mastery");

    _add("Warrior", [uint32(16), 8, 8], guiseSkills);
  }

  function _add(string memory name, uint32[PStat_length] levelMul, bytes32[] memory guiseSkills) private {
    uint256 entity = getUniqueEntity();

    GuisePrototype.set(entity, levelMul);

    AvailableSkills.set(entity, guiseSkills);
    Name.set(entity, name);
  }
}
