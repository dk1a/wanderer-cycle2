// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";

import { FromPrototype } from "../codegen/Tables.sol";

//import { LibLootEquipment } from "./LibLootEquipment.sol";
//import { LibLootMint } from "./LibLootMint.sol";

/// @title Mint a random equippable loot entity.
contract RandomEquipmentSubSystem is System {
  /// @param ilvl higher ilvl increases the pool of affixes for random generation (higher is better).
  /// @param randomness used to randomly pick equipment prototype and affixes.
  /// @return lootEntity a new entity.

  function execute(uint32 ilvl, uint256 randomness) internal override returns (uint256 lootEntity) {
    // pick equipment prototype (it's the targetEntity when getting affix availability)
    //    bytes32 equipmentProtoEntity = LibLootEquipment.pickEquipmentPrototype(ilvl, randomness);
    // get a new unique id
    bytes32 lootEntity = getUniqueEntity();
    // make random loot (affixes and effect)
    //    LibLootMint.randomLootMint(
    //      LibLootEquipment.getAffixPartIds(ilvl),
    //      lootEntity,
    //      equipmentProtoEntity,
    //      ilvl,
    //      randomness
    //    );
    // set loot's equipment prototype (to make it equippable)
    //    FromPrototype.set(lootEntity, equipmentProtoEntity);

    return lootEntity;
  }
}
