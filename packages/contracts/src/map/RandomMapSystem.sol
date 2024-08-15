// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { System } from "@latticexyz/world/src/System.sol";
import { getUniqueEntity } from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";

import { LibLootEquipment } from "../loot/LibLootEquipment.sol";
import { LibLootMint } from "../loot/LibLootMint.sol";
import { LibLootMap } from "../loot/LibLootMap.sol";

/// @title Mint a random map entity.
contract RandomMapSystem is System {
  /// @param ilvl higher ilvl increases the pool of affixes for random generation (higher is better).
  /// @param mapBaseEntity map prototype.
  /// @param randomness used to randomly pick equipment prototype and affixes.
  /// @return lootEntity a new entity.
  function mintRandomMapEntity(
    uint32 ilvl,
    bytes32 mapBaseEntity,
    uint256 randomness
  ) internal returns (bytes32 lootEntity) {
    // get a new unique id
    bytes32 lootEntity = getUniqueEntity();
    // make random loot (affixes and effect)
    LibLootMint.randomLootMint(LibLootMap.getAffixPartIds(ilvl), lootEntity, mapBaseEntity, ilvl, randomness);
    // TODO set map type

    return lootEntity;
  }
}
