// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { System } from "@latticexyz/world/src/System.sol";
import { getUniqueEntity } from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";

import { FromPrototype } from "../codegen/index.sol";

import { LibLootEquipment } from "./LibLootEquipment.sol";
import { LibLootMint } from "./LibLootMint.sol";

/// @title Mint a random map entity.
contract RandomMapSystem is System {
  /// @param ilvl higher ilvl increases the pool of affixes for random generation (higher is better).
  /// @param mapProtoEntity map prototype.
  /// @param randomness used to randomly pick equipment prototype and affixes.
  /// @return lootEntity a new entity.

  function mintRandomMapEntity(
    uint32 ilvl,
    bytes32 mapProtoEntity,
    uint256 randomness
  ) internal override returns (bytes32 lootEntity) {
    // get a new unique id
    uint256 lootEntity = getUniqueEntity();
    // make random loot (affixes and effect)
    LibLootMint.randomLootMint(LibLootMap.getAffixPartIds(ilvl), lootEntity, mapProtoEntity, ilvl, randomness);
    // set loot's map prototype
    FromPrototype.set(lootEntity, mapProtoEntity);

    return lootEntity;
  }
}
