// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { getUniqueEntity } from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";

import { Name, MapBase } from "../codegen/index.sol";
import { MapPrototype, MapPrototypes } from "./MapPrototypes.sol";

library LibSpawnMaps {
  function init() private {
    _createNewMapPrototype("Global Basic", MapPrototypes.GLOBAL_BASIC);
    _createNewMapPrototype("Global Random", MapPrototypes.GLOBAL_RANDOM);
    _createNewMapPrototype("Global Cycle Boss", MapPrototypes.GLOBAL_CYCLE_BOSS);
  }

  function _createNewMapPrototype(
    string memory mapName,
    MapPrototype mapPrototype
  ) private returns (bytes32 _mapProto) {
    bytes32 mapProto = getUniqueEntity();
    Name.set(mapProto, mapName);
    //TODO create new logic for MapBase.set()
    MapBase.set(mapProto, mapPrototype.toBytes32());
  }
}
