// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { IStore } from "@latticexyz/store/src/IStore.sol";

import { MODULE_NAMESPACE } from "./constants.sol";
import { Duration } from "../codegen/tables/Duration.sol";
import { getTargetTableSelector } from "@latticexyz/world/src/modules/utils/getTargetTableSelector.sol";

function getDurationEntity(
  bytes32 tableId,
  bytes32 targetEntity,
  bytes32 baseEntity
) view returns (bytes32 durationEntity) {
  bytes32 durationTableId = getTargetTableSelector(MODULE_NAMESPACE, tableId);

  durationEntity = Duration.get(durationTableId, targetEntity, baseEntity);
}

function getDurationEntity(
  IStore store,
  bytes32 tableId,
  bytes32 targetEntity,
  bytes32 baseEntity
) view returns (bytes32 durationEntity) {
  bytes32 durationTableId = getTargetTableSelector(MODULE_NAMESPACE, tableId);

  durationEntity = Duration.get(store, durationTableId, targetEntity, baseEntity);
}
