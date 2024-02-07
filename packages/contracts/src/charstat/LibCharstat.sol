// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { hasKey } from "@latticexyz/world-modules/src/modules/keysintable/hasKey.sol";

import { Experience, LifeCurrent, ManaCurrent } from "../codegen/index.sol";

import { Statmod } from "../statmod/Statmod.sol";
import { StatmodTopics } from "../statmod/StatmodTopics.sol";
import { LibExperience } from "./LibExperience.sol";

import { StatmodOp, EleStat } from "../codegen/common.sol";
import { PStat, PStat_length, EleStat_length } from "../CustomTypes.sol";

library LibCharstat {
  struct Self {
    bytes32 targetEntity;
    PStat pstatIndex;
    StatmodOp statmodOp;
    EleStat elestat;
  }

  // ========== PRIMARY STATS (strength, arcana, dexterity) ==========
  function getBasePStat(
    bytes32 targetEntity,
    PStat pstatIndex,
    StatmodOp statmodOp,
    EleStat elestat
  ) internal view returns (uint32) {
    if (LibExperience.hasExp(targetEntity)) {
      // if entity uses exp component, use that for primary stats
      return LibExperience.getPStat(targetEntity, pstatIndex);
    } else {
      // otherwise try a special statmod
      return Statmod.getValuesFinal(targetEntity, StatmodTopics.LEVEL.toStatmodEntity(statmodOp, elestat), 0);
    }
  }

  function getPStat(
    bytes32 targetEntity,
    StatmodOp statmodOp,
    EleStat elestat,
    PStat pstat
  ) internal view returns (uint32) {
    uint32 baseValue = getBasePStat(targetEntity, pstatIndex, statmodOp, elestat);

    return
      Statmod.getValuesFinal(
        targetEntity,
        StatmodTopics.PSTAT()[uint256(pstat)].toStatmodEntity(statmodOp, elestat),
        baseValue
      );
  }

  function getPStats(
    bytes32 targetEntity,
    StatmodOp statmodOp,
    EleStat elestat
  ) internal view returns (uint32[PStat_length] memory pstats) {
    for (uint256 i; i < PStat_length; i++) {
      pstats[i] = getPStat(targetEntity, statmodOp, elestat, PStat(i));
    }
    return pstats;
  }

  // ========== ATTRIBUTES ==========
  function getLife(bytes32 targetEntity, StatmodOp statmodOp, EleStat elestat) internal view returns (uint32) {
    uint32 strength = getPStat(targetEntity, statmodOp, elestat, PStat.STRENGTH);
    uint32 baseValue = 2 + 2 * strength;

    return Statmod.getValuesFinal(StatmodTopics.LIFE.toStatmodEntity(statmodOp, elestat), baseValue);
  }

  function getMana(bytes32 targetEntity, StatmodOp statmodOp, EleStat elestat) internal view returns (uint32) {
    uint32 arcana = getPStat(targetEntity, statmodOp, elestat, PStat.ARCANA);
    uint32 baseValue = 4 * arcana;

    return Statmod.getValuesFinal(StatmodTopics.MANA.toStatmodEntity(statmodOp, elestat), baseValue);
  }

  function getFortune(bytes32 targetEntity, StatmodOp statmodOp, EleStat elestat) internal view returns (uint32) {
    return Statmod.getValuesFinal(StatmodTopics.FORTUNE.toStatmodEntity(statmodOp, elestat), 0);
  }

  function getConnection(bytes32 targetEntity, StatmodOp statmodOp, EleStat elestat) internal view returns (uint32) {
    return Statmod.getValuesFinal(StatmodTopics.CONNECTION.toStatmodEntity(statmodOp, elestat), 0);
  }

  function getLifeRegen(bytes32 targetEntity, StatmodOp statmodOp, EleStat elestat) internal view returns (uint32) {
    return Statmod.getValuesFinal(StatmodTopics.LIFE_GAINED_PER_TURN.toStatmodEntity(statmodOp, elestat), 0);
  }

  // ========== ELEMENTAL ==========
  function getAttack(
    bytes32 targetEntity,
    StatmodOp statmodOp,
    EleStat elestat
  ) internal view returns (uint32[EleStat_length] memory) {
    uint32 strength = getPStat(targetEntity, statmodOp, elestat, PStat.STRENGTH);
    // strength increases physical base attack damage
    uint32[EleStat_length] memory baseValues = [uint32(0), strength / 2 + 1, 0, 0, 0];

    return Statmod.getValuesFinal(StatmodTopics.ATTACK.toStatmodEntity(statmodOp, elestat), baseValue);
  }

  function getSpell(
    bytes32 targetEntity,
    StatmodOp statmodOp,
    EleStat elestat,
    uint32[EleStat_length] memory baseValues
  ) internal view returns (uint32[EleStat_length] memory) {
    uint32 arcana = getPStat(targetEntity, statmodOp, elestat, PStat.ARCANA);
    // arcana increases non-zero base spell damage
    for (uint256 i; i < EleStat_length; i++) {
      if (baseValues[i] > 0) {
        // TODO u sure it's fine to modify in-place like that?
        baseValues[i] += arcana;
      }
    }

    return Statmod.getValuesFinal(StatmodTopics.SPELL.toStatmodEntity(statmodOp, elestat), baseValue);
  }

  function getResistance(
    bytes32 targetEntity,
    StatmodOp statmodOp,
    EleStat elestat
  ) internal view returns (uint32[EleStat_length] memory) {
    uint32 dexterity = getPStat(targetEntity, statmodOp, elestat, PStat.DEXTERITY);
    // dexterity increases base physical resistance
    uint32[EleStat_length] memory baseValues = [uint32((dexterity / 4) * 4), 0, 0, 0, 0];

    return Statmod.getValuesFinal(StatmodTopics.RESISTANCE.toStatmodEntity(statmodOp, elestat), baseValue);
  }

  // ========== CURRENTS ==========
  function getLifeCurrent(bytes32 targetEntity, StatmodOp statmodOp, EleStat elestat) internal view returns (uint32) {
    uint32 lifeMax = getLife(targetEntity, statmodOp, elestat);
    uint32 lifeCurrent = LifeCurrent.get(targetEntity);
    if (lifeCurrent > lifeMax) {
      return lifeMax;
    } else {
      return uint32(lifeCurrent);
    }
  }

  function setLifeCurrent(bytes32 targetEntity, uint32 value) internal {
    LifeCurrent.set(targetEntity, value);
  }

  function getManaCurrent(bytes32 targetEntity, StatmodOp statmodOp, EleStat elestat) internal view returns (uint32) {
    uint32 manaMax = getMana(targetEntity, statmodOp, elestat);
    uint32 manaCurrent = ManaCurrent.get(targetEntity);

    if (manaCurrent > manaMax) {
      return manaMax;
    } else {
      return uint32(manaCurrent);
    }
  }

  function setManaCurrent(bytes32 targetEntity, uint32 value) internal {
    ManaCurrent.set(targetEntity, value);
  }

  /**
   * @dev Set currents to max values
   */
  function setFullCurrents(bytes32 targetEntity, StatmodOp statmodOp, EleStat elestat) internal {
    setLifeCurrent(targetEntity, getLife(targetEntity, statmodOp, elestat));
    setManaCurrent(targetEntity, getMana(targetEntity, statmodOp, elestat));
  }

  // ========== ROUND DAMAGE ==========
  function getRoundDamage(StatmodOp statmodOp, EleStat elestat) internal view returns (uint32[EleStat_length] memory) {
    return Statmod.getValuesFinal(StatmodTopics.SPELL.toStatmodEntity(statmodOp, elestat), [uint32(0), 0, 0, 0, 0]);
  }
}
