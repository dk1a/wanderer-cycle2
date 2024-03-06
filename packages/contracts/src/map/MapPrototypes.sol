// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

type MapPrototype is bytes32;

library MapPrototypes {
  MapPrototype constant GLOBAL_BASIC = MapPrototype.wrap("Global Basic");
  MapPrototype constant GLOBAL_RANDOM = MapPrototype.wrap("Global Random");
  MapPrototype constant GLOBAL_CYCLE_BOSS = MapPrototype.wrap("Global Cycle Boss");
}

using { toBytes32, eq as ==, ne as != } for MapPrototype global;

function toBytes32(MapPrototype mapPrototype) pure returns (bytes32) {
  return MapPrototype.unwrap(mapPrototype);
}

function eq(MapPrototype a, MapPrototype b) pure returns (bool) {
  return MapPrototype.unwrap(a) == MapPrototype.unwrap(b);
}

function ne(MapPrototype a, MapPrototype b) pure returns (bool) {
  return MapPrototype.unwrap(a) != MapPrototype.unwrap(b);
}
