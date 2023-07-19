// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { IStore } from "@latticexyz/store/src/IStore.sol";

import { getTargetTableSelector } from "@latticexyz/world/src/modules/utils/getTargetTableSelector.sol";
import { MODULE_NAMESPACE } from "./constants.sol";
import { Duration } from "../codegen/tables/Duration.sol";

function getKeysWithValue(
  bytes memory tableId,
  bytes32 targetEntity,
  bytes32 baseEntity
) view returns (bytes32 durationEntity) {
  bytes32 durationTableId = getTargetTableSelector(MODULE_NAMESPACE, tableId);

  durationEntity = Duration.get(keysWithValueTableId, targetEntity, baseEntity);
}

function getKeysWithValue(
  IStore store,
  bytes memory tableId,
  bytes32 targetEntity,
  bytes32 baseEntity
) view returns (bytes32 durationEntity) {
  bytes32 durationTableId = getTargetTableSelector(MODULE_NAMESPACE, tableId);

  durationEntity = Duration.get(store, keysWithValueTableId, targetEntity, baseEntity);
}
