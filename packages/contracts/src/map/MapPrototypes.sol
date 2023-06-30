// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { MapBaseTableId } from "../codegen/Tables.sol";

library MapPrototypes {
  bytes32 constant GLOBAL_BASIC = bytes32(keccak256(abi.encode(MapBaseTableId, "Global Basic")));
  bytes32 constant GLOBAL_RANDOM = bytes32(keccak256(abi.encode(MapBaseTableId, "Global Random")));
  bytes32 constant GLOBAL_CYCLE_BOSS = bytes32(keccak256(abi.encode(MapBaseTableId, "Global Cycle Boss")));
}
