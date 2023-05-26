// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import { IUint256Component } from "@latticexyz/solecs/src/interfaces/IUint256Component.sol";

import { Experience, ExperienceTableId } from "../codegen/Tables.sol";
import { ActiveGuise, ActiveGuiseTableId } from "../codegen/Tables.sol";
import { GuisePrototype, GuisePrototypeTableId } from "../codegen/Tables.sol";

import { PStat, PStat_length } from "../CustomTypes.sol";
import { LibExperience } from "../charstat/LibExperience.sol";

library LibGuiseLevel {
  using LibExperience for *;

  /// @dev Get target's aggregate level using its guise's level multipliers.
  /// (aggregate level means all primary stats aggregated together)
  function getAggregateLevel(IUint256Component components, uint256 targetEntity) internal view returns (uint32) {
    LibExperience memory exp = LibExperience.getExp(targetEntity);

    uint256 guiseProtoEntity = ActiveGuise.get(targetEntity);
    uint32[PStat_length] memory levelMul = GuisePrototype.get(guiseProtoEntity);
    return exp.getAggregateLevel(levelMul);
  }

  /// @dev Multiply gained experience by guise's level multiplier
  function multiplyExperience(
    IUint256Component components,
    uint256 targetEntity,
    uint32[PStat_length] memory exp
  ) internal view returns (uint32[PStat_length] memory expMultiplied) {
    uint256 guiseProtoEntity = ActiveGuise.get(targetEntity);
    uint32[PStat_length] memory levelMul = GuisePrototype.get(guiseProtoEntity);

    for (uint256 i; i < PStat_length; i++) {
      expMultiplied[i] = exp[i] * levelMul[i];
    }
    return expMultiplied;
  }
}
