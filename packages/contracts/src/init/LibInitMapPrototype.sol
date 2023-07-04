// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";

import { MapBase, Name } from "../codegen/Tables.sol";

import { MapPrototypes } from "../map/MapPrototypes.sol";

library LibInitMapPrototype {
  function init() internal {
    _set(MapPrototypes.GLOBAL_BASIC, "Global Basic");
    _set(MapPrototypes.GLOBAL_RANDOM, "Global Random");
    _set(MapPrototypes.GLOBAL_CYCLE_BOSS, "Global Cycle Boss");
  }

  function _set(bytes32 protoEntity, string memory name) internal {
    bytes32 entity = getUniqueEntity();

    MapBase.set(entity, protoEntity);
    Name.set(protoEntity, name);
  }
}
