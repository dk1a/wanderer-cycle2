// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { ActiveGuise, ActiveGuiseTableId } from "../codegen/Tables.sol";
import { GuisePrototype, GuisePrototypeTableId } from "../codegen/Tables.sol";

import { PStat_length } from "../CustomTypes.sol";
import { LibExperience } from "../charstat/LibExperience.sol";

library LibGuiseLevel {
  /// @dev Get target's aggregate level using its guise's level multipliers.
  /// (aggregate level means all primary stats aggregated together)
  function getAggregateLevel(bytes32 targetEntity) internal view returns (uint32) {
    uint256 guiseProtoEntity = ActiveGuise.get(targetEntity);
    uint32[PStat_length] memory levelMul = GuisePrototype.get(bytes32(guiseProtoEntity));
    return LibExperience.getAggregateLevel(targetEntity, levelMul);
  }

  /// @dev Multiply gained experience by guise's level multiplier
  function multiplyExperience(
    bytes32 targetEntity,
    uint32[PStat_length] memory exp
  ) internal view returns (uint32[PStat_length] memory expMultiplied) {
    uint256 guiseProtoEntity = ActiveGuise.get(targetEntity);
    uint32[PStat_length] memory levelMul = GuisePrototype.get(bytes32(guiseProtoEntity));

    for (uint256 i; i < PStat_length; i++) {
      expMultiplied[i] = exp[i] * levelMul[i];
    }
    return expMultiplied;
  }
}
