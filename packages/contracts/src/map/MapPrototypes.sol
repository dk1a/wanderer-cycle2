// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

// import { getUniqueEntity } from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";

// import { MapBase, Name } from "../codegen/index.sol";

// library MapPrototypes {
//   string constant GLOBAL_BASIC = "Global Basic";
//   string constant GLOBAL_RANDOM = "Global Random";
//   string constant GLOBAL_CYCLE_BOSS = "Global Cycle Boss";

//   function createNewMapPrototype() private {
//     _createNewMapPrototype(GLOBAL_BASIC);
//     _createNewMapPrototype(GLOBAL_RANDOM);
//     _createNewMapPrototype(GLOBAL_CYCLE_BOSS);
//   }

//   function _createNewMapPrototype(string memory mapName) private returns (bytes32 _mapProto) {
//     bytes32 mapProto = getUniqueEntity();
//     Name.set(mapProto, mapName);
//     //TODO create new logic for MapBase.set()
//     MapBase.set(mapProto, mapName);
//   }
// }
