// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { getKeysWithValue } from "@latticexyz/world/src/modules/keyswithvalue/getKeysWithValue.sol";

import { LibArray } from "../libraries/LibArray.sol";

import { AffixPartId } from "../codegen/Types.sol";

import { AffixAvailable } from "../codegen/Tables.sol";
import { AffixNaming } from "../codegen/Tables.sol";
import { AffixPrototype, AffixPrototypeData } from "../codegen/Tables.sol";
import { AffixProtoIndex } from "../codegen/Tables.sol";
import { AffixProtoGroup, AffixProtoGroupTableId } from "../codegen/Tables.sol";
import { Affix, AffixData } from "../codegen/Tables.sol";

/// @title Randomly pick affixes.
library LibPickAffixes {
  error LibPickAffixes__NoAvailableAffix(AffixPartId affixPartId, bytes32 protoEntity, uint32 ilvl);
  error LibPickAffixes__InvalidMinMax();
  error LibPickAffixes__InvalidIlvl(uint32 ilvl);

  function pickAffixes(
    AffixPartId[] memory affixPartIds,
    uint32[] memory excludeAffixes,
    bytes32 targetEntity,
    uint32 ilvl,
    uint32 randomness
  )
    internal
    view
    returns (uint32[] memory statmodProtoEntities, uint32[] memory affixProtoEntities, uint32[] memory affixValues)
  {
    statmodProtoEntities = new uint32[](affixPartIds.length);
    affixProtoEntities = new uint32[](affixPartIds.length);
    affixValues = new uint32[](affixPartIds.length);

    for (uint256 i; i < affixPartIds.length; i++) {
      randomness = uint32(keccak256(abi.encode(i, randomness)));
      // pick affix proto entity
      bytes32 affixProtoEntity = _pickAffixProtoEntity(ilvl, affixPartIds[i], targetEntity, excludeAffixes, randomness);
      AffixPrototypeData memory affixProto = AffixPrototype.get(affixProtoEntity);
      // set the corresponding statmod
      statmodProtoEntities[i] = affixProto.statmodProtoEntity;

      // pick its value
      affixProtoEntities[i] = affixProtoEntity;
      affixValues[i] = _pickAffixValue(affixProto, randomness);

      if (i != affixPartIds.length - 1) {
        // exclude all affixes from the picked affix's group (skip for the last cycle)
        uint32[] memory newExcludeAffixes = getKeysWithValue(
          AffixProtoGroupTableId,
          AffixProtoGroup.get(affixProtoEntity)
        );
        excludeAffixes = LibArray.concat(excludeAffixes, newExcludeAffixes);
      }
    }
  }

  function manuallyPickAffixesMax(
    string[] memory names,
    uint32[] memory tiers
  )
    internal
    view
    returns (uint32[] memory statmodProtoEntities, uint32[] memory affixProtoEntities, uint32[] memory affixValues)
  {
    uint32 len = names.length;
    statmodProtoEntities = new uint32[](len);
    affixProtoEntities = new uint32[](len);
    affixValues = new uint32[](len);

    for (uint32 i; i < names.length; i++) {
      affixProtoEntities[i] = getAffixProtoEntity(names[i], tiers[i]);

      AffixPrototypeData memory affixProto = AffixPrototype.get(affixProtoEntities[i]);
      statmodProtoEntities[i] = affixProto.statmodProtoEntity;

      affixValues[i] = affixProto.max;
    }
  }

  /// @dev Randomly pick an affix entity from the available set.
  function _pickAffixProtoEntity(
    uint32 ilvl,
    AffixPartId affixPartId,
    bytes32 targetEntity,
    uint32[] memory excludeAffixes,
    uint32 randomness
  ) internal view returns (uint32) {
    randomness = uint32(keccak256(abi.encode(keccak256("pickAffixEntity"), randomness)));

    // TODO this can be significantly optimized if you need it
    uint32 availabilityEntity = AffixAvailable.get(affixPartId, targetEntity, ilvl);
    uint256[] memory entities = _getAvailableEntities(availabilityEntity, excludeAffixes);
    if (entities.length == 0) revert LibPickAffixes__NoAvailableAffix(affixPartId, targetEntity, ilvl);

    uint256 index = randomness % entities.length;
    return entities[index];
  }

  /// @dev Queries the default availability and removes `excludeEntities` from it.
  function _getAvailableEntities(
    uint32 ilvl,
    AffixPartId affixPartId,
    bytes32 targetEntity,
    bytes32[] memory excludeEntities
  ) private view returns (uint256[] memory availableEntities) {
    // get default availability
    availableEntities = AffixAvailable.get(affixPartId, targetEntity, ilvl);

    for (uint256 i; i < availableEntities.length; i++) {
      // exclude the specified entities
      if (LibArray.isIn(availableEntities[i], excludeEntities)) {
        uint256 len = availableEntities.length;
        // swap and pop
        availableEntities[i] = availableEntities[len - 1];
        /// @solidity memory-safe-assembly
        assembly {
          // shorten the array length
          mstore(availableEntities, sub(len, 1))
        }
      }
    }
    return availableEntities;
  }

  /// @dev Randomly pick an affix value.
  function _pickAffixValue(AffixPrototypeData memory affixProto, uint32 randomness) internal pure returns (uint32) {
    randomness = uint32(keccak256(abi.encode(keccak256("_pickAffixValue"), randomness)));

    if (affixProto.max < affixProto.min) revert LibPickAffixes__InvalidMinMax();
    if (affixProto.max == affixProto.min) return affixProto.min;

    uint32 range = affixProto.max - affixProto.min;
    uint32 result = uint32(randomness % range);
    return result + affixProto.min;
  }
}
