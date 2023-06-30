// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";

import { FromPrototype } from "../codegen/Tables.sol";
import { AffixPartId } from "../CustomTypes.sol";

import { LibLootMint } from "../loot/LibLootMint.sol";
import { MapPrototypes } from "../map/MapPrototypes.sol";

library LibInitMapsGlobal {
  function init() internal {
    // Hardcoded map level range
    for (uint32 ilvl = 1; ilvl <= 12; ilvl++) {
      _setBasic(ilvl);
    }
    for (uint32 ilvl = 2; ilvl <= 10; ilvl += 4) {
      uint256 randomness = uint256(keccak256(abi.encode("global random map", ilvl, blockhash(block.number))));
      _setRandom(ilvl, randomness);
    }
  }

  function _setBasic(uint32 ilvl) private {
    // global basic maps only have the implicit affix
    AffixPartId[] memory affixParts = new AffixPartId[](1);
    affixParts[0] = AffixPartId.IMPLICIT;

    //TODO lootEntity?
    // get a new unique id
    bytes32 lootEntity = getUniqueEntityId();
    // not really random, there's only 1 implicit per ilvl, it's just easier to reuse this function
    LibLootMint.randomLootMint(affixParts, lootEntity, MapPrototypes.GLOBAL_BASIC, ilvl, 0);
    // set loot's map prototype
    FromPrototype.set(lootEntity, MapPrototypes.GLOBAL_BASIC);
  }

  function _setRandom(uint32 ilvl, uint256 randomness) private {
    AffixPartId[] memory affixParts = new AffixPartId[](3);
    affixParts[0] = AffixPartId.IMPLICIT;
    affixParts[1] = AffixPartId.SUFFIX;
    affixParts[2] = AffixPartId.PREFIX;

    // get a new unique id
    bytes32 lootEntity = getUniqueEntityId();
    LibLootMint.randomLootMint(affixParts, lootEntity, MapPrototypes.GLOBAL_RANDOM, ilvl, randomness);
    // set loot's map prototype
    FromPrototype.set(lootEntity, MapPrototypes.GLOBAL_RANDOM);
  }
}
