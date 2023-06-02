// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { getKeysWithValue } from "@latticexyz/world/src/modules/keyswithvalue/getKeysWithValue.sol";

import { LibArray } from "../libraries/LibArray.sol";

import { AffixPartId } from "../codegen/Types.sol";
import { AffixAvailable, AffixAvailableTableId } from "../codegen/Tables.sol";
import { AffixNaming, AffixNamingTableId } from "../codegen/Tables.sol";
import { AffixPrototype, AffixPrototypeData, AffixPrototypeTableId } from "../codegen/Tables.sol";
import { AffixProtoIndex, AffixProtoIndexTableId } from "../codegen/Tables.sol";
import { AffixProtoGroup, AffixProtoGroupTableId } from "../codegen/Tables.sol";
import { Affix, AffixData, AffixTableId } from "../codegen/Tables.sol";

/// @title Randomly pick affixes.
library LibPickAffixes {
  error LibPickAffixes__NoAvailableAffix(uint256 ilvl, AffixPartId affixPartId, bytes32 protoEntity);
  error LibPickAffixes__InvalidMinMax();
  error LibPickAffixes__InvalidIlvl(uint256 ilvl);

  function pickAffixes(
    AffixPartId[] memory affixPartIds,
    uint256[] memory excludeAffixes,
    bytes32 targetEntity,
    uint256 ilvl,
    uint256 randomness
  )
    internal
    view
    returns (uint256[] memory statmodProtoEntities, uint256[] memory affixProtoEntities, uint32[] memory affixValues)
  {
    statmodProtoEntities = new uint256[](affixPartIds.length);
    affixProtoEntities = new uint256[](affixPartIds.length);
    affixValues = new uint32[](affixPartIds.length);

    for (uint256 i; i < affixPartIds.length; i++) {
      randomness = uint256(keccak256(abi.encode(i, randomness)));
      // pick affix proto entity
      uint256 affixProtoEntity = _pickAffixProtoEntity(ilvl, affixPartIds[i], targetEntity, excludeAffixes, randomness);
      AffixPrototypeData memory affixProto = AffixPrototype.get(bytes32(affixProtoEntity));
      // set the corresponding statmod
      statmodProtoEntities[i] = uint256(affixProto.statmodProtoEntity);

      // pick its value
      affixProtoEntities[i] = affixProtoEntity;
      affixValues[i] = _pickAffixValue(affixProto, randomness);

      if (i != affixPartIds.length - 1) {
        // exclude all affixes from the picked affix's group (skip for the last cycle)
        bytes32[] memory newExcludeAffixes = getKeysWithValue(
          AffixProtoGroupTableId,
          AffixProtoGroup.get(bytes32(affixProtoEntity))
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
    returns (uint256[] memory statmodProtoEntities, uint256[] memory affixProtoEntities, uint32[] memory affixValues)
  {
    uint256 len = names.length;
    statmodProtoEntities = new uint256[](len);
    affixProtoEntities = new bytes32[](len);
    affixValues = new uint32[](len);

    for (uint256 i; i < names.length; i++) {
      affixProtoEntities[i] = AffixProtoIndex.get(bytes32(names[i]), tiers[i]);

      AffixPrototypeData memory affixProto = AffixPrototype.get(bytes32(affixProtoEntities[i]));
      statmodProtoEntities[i] = affixProto.statmodProtoEntity;

      affixValues[i] = affixProto.max;
    }
  }

  /// @dev Randomly pick an affix entity from the available set.
  function _pickAffixProtoEntity(
    uint256 ilvl,
    AffixPartId affixPartId,
    bytes32 targetEntity,
    uint256[] memory excludeAffixes,
    uint256 randomness
  ) internal view returns (uint256) {
    randomness = uint256(keccak256(abi.encode(keccak256("pickAffixEntity"), randomness)));

    //    uint256 availabilityEntity = AffixAvailable.getItem(affixPartId, targetEntity, ilvl);
    uint256[] memory entities = _getAvailableEntities(affixPartId, targetEntity, ilvl, excludeAffixes);
    if (entities.length == 0) revert LibPickAffixes__NoAvailableAffix(ilvl, affixPartId, targetEntity);

    uint256 index = randomness % entities.length;
    return entities[index];
  }

  /// @dev Queries the default availability and removes `excludeEntities` from it.
  function _getAvailableEntities(
    AffixPartId affixPartId,
    bytes32 targetEntity,
    uint256 ilvl,
    uint256[] memory excludeEntities
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
  function _pickAffixValue(AffixPrototypeData memory affixProto, uint256 randomness) internal pure returns (uint32) {
    randomness = uint256(keccak256(abi.encode(keccak256("_pickAffixValue"), randomness)));

    if (affixProto.max < affixProto.min) revert LibPickAffixes__InvalidMinMax();
    if (affixProto.max == affixProto.min) return affixProto.min;

    uint32 range = affixProto.max - affixProto.min;
    uint32 result = uint32(randomness % uint256(range));
    return result + affixProto.min;
  }
}
