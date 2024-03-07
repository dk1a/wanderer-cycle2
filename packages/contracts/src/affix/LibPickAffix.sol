// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { getKeysWithValue } from "@latticexyz/world-modules/src/modules/keyswithvalue/getKeysWithValue.sol";

import { AffixPartId } from "../codegen/common.sol";
import { AffixAvailable, AffixNaming, AffixPrototype, AffixPrototypeData, AffixProtoIndex, AffixProtoGroup, AffixProtoGroupTableId, Affix, AffixData } from "../codegen/index.sol";

import { LibArray } from "../libraries/LibArray.sol";

/// @title Randomly pick affixes.
library LibPickAffixes {
  error LibPickAffixes__NoAvailableAffix(AffixPartId affixPartId, bytes32 protoEntity, uint32 ilvl);
  error LibPickAffixes__InvalidMinMax();
  error LibPickAffixes__InvalidIlvl(uint32 ilvl);

  function pickAffixes(
    AffixPartId[] memory affixPartIds,
    bytes32 targetEntity,
    uint32 ilvl,
    uint256 randomness
  )
    internal
    view
    returns (bytes32[] memory statmodProtoEntities, bytes32[] memory affixProtoEntities, uint32[] memory affixValues)
  {
    statmodProtoEntities = new bytes32[](affixPartIds.length);
    affixProtoEntities = new bytes32[](affixPartIds.length);
    affixValues = new uint32[](affixPartIds.length);

    for (uint256 i; i < affixPartIds.length; i++) {
      randomness = uint256(keccak256(abi.encode(i, randomness)));
      // pick affix proto entity
      bytes32 affixProtoEntity = _pickAffixProtoEntity(ilvl, affixPartIds[i], targetEntity, randomness);
      AffixPrototypeData memory affixProto = AffixPrototype.get(affixProtoEntity);
      // set the corresponding statmod
      statmodProtoEntities[i] = affixProto.statmodProtoEntity;

      // pick its value
      affixProtoEntities[i] = affixProtoEntity;
      affixValues[i] = _pickAffixValue(affixProto, randomness);

      // if (i != affixPartIds.length - 1) {
      //   // exclude all affixes from the picked affix's group (skip for the last cycle)
      //   bytes32[] memory newExcludeAffixes = getKeysWithValue(
      //     AffixProtoGroupTableId,
      //     AffixProtoGroup.get(affixProtoEntity)
      //   );
      //   excludeAffixes = LibArray.concat(excludeAffixes, newExcludeAffixes);
      // }
    }
  }

  function manuallyPickAffixesMax(
    string[] memory names,
    uint32[] memory tiers
  )
    internal
    view
    returns (bytes32[] memory statmodProtoEntities, bytes32[] memory affixProtoEntities, uint32[] memory affixValues)
  {
    uint256 len = names.length;
    statmodProtoEntities = new bytes32[](len);
    affixProtoEntities = new bytes32[](len);
    affixValues = new uint32[](len);

    for (uint32 i; i < names.length; i++) {
      affixProtoEntities[i] = AffixProtoIndex.get(keccak256(abi.encodePacked(names[i])), tiers[i]);

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
    uint256 randomness
  ) internal view returns (bytes32) {
    randomness = uint256(keccak256(abi.encode(keccak256("pickAffixEntity"), randomness)));

    // TODO this can be significantly optimized if you need it
    bytes32[] memory availableEntities = AffixAvailable.get(affixPartId, targetEntity, ilvl);
    if (availableEntities.length == 0) revert LibPickAffixes__NoAvailableAffix(affixPartId, targetEntity, ilvl);

    uint256 index = randomness % availableEntities.length;
    return availableEntities[index];
  }

  /// @dev Queries the default availability and removes `excludeEntities` from it.
  function _getAvailableEntities(
    uint32 ilvl,
    AffixPartId affixPartId,
    bytes32 targetEntity,
    bytes32[] memory excludeEntities
  ) private view returns (bytes32[] memory availableEntities) {
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
  function _pickAffixValue(AffixPrototypeData memory affixProto, uint256 randomness) internal pure returns (uint32) {
    randomness = uint256(keccak256(abi.encode(keccak256("_pickAffixValue"), randomness)));

    if (affixProto.max < affixProto.min) revert LibPickAffixes__InvalidMinMax();
    if (affixProto.max == affixProto.min) return affixProto.min;

    uint32 range = affixProto.max - affixProto.min;
    uint32 result = uint32(randomness % range);
    return result + affixProto.min;
  }
}
