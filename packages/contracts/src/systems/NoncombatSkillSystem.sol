// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";

//import { LibSkill } from "../skill/LibSkill.sol";

contract NoncombatSkillSystem is System {
  error NoncombatSkillSystem__Asd();

  function execute(bytes32 cycleEntity, bytes32 skillEntity) public override {
    //    LibCycle.requirePermission(cycleEntity);
    //
    //    LibSkill.Self memory libSkill = LibSkill.__construct(world, cycleEntity, skillEntity);
    //    LibSkill.requireNonCombat();
    //
    //    LibSkill.useSkill(cycleEntity);
    //
    return "";
  }
}
