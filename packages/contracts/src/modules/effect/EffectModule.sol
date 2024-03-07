// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { BEFORE_DELETE_RECORD } from "@latticexyz/store/src/storeHookTypes.sol";
import { ResourceIds } from "@latticexyz/store/src/codegen/tables/ResourceIds.sol";

import { Module } from "@latticexyz/world/src/Module.sol";

import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";

import { revertWithBytes } from "@latticexyz/world/src/revertWithBytes.sol";

import { EffectDurationHook } from "./EffectDurationHook.sol";
import { EffectDuration, EffectDurationTableId, EffectTemplate, EffectTemplateTableId, EffectApplied, EffectAppliedTableId, StatmodValueTableId } from "../../codegen/index.sol";

contract EffectModule is Module {
  // The EffectDurationHook is deployed once and always uses the hardcoded EffectDurationTableId
  EffectDurationHook private immutable hook = new EffectDurationHook();

  function installRoot(bytes memory) public override {
    requireNotInstalled(__self, "");

    IBaseWorld world = IBaseWorld(_world());

    // Initialize variable to reuse in low level calls
    bool success;
    bytes memory returnData;

    // Register the tables
    if (!ResourceIds._getExists(EffectDurationTableId)) {
      (success, returnData) = address(world).delegatecall(
        abi.encodeCall(
          world.registerTable,
          (
            EffectDurationTableId,
            EffectDuration.getFieldLayout(),
            EffectDuration.getKeySchema(),
            EffectDuration.getValueSchema(),
            EffectDuration.getKeyNames(),
            EffectDuration.getFieldNames()
          )
        )
      );
      if (!success) revertWithBytes(returnData);
    }
    if (!ResourceIds._getExists(EffectTemplateTableId)) {
      (success, returnData) = address(world).delegatecall(
        abi.encodeCall(
          world.registerTable,
          (
            EffectTemplateTableId,
            EffectTemplate.getFieldLayout(),
            EffectTemplate.getKeySchema(),
            EffectTemplate.getValueSchema(),
            EffectTemplate.getKeyNames(),
            EffectTemplate.getFieldNames()
          )
        )
      );
      if (!success) revertWithBytes(returnData);
    }
    if (!ResourceIds._getExists(EffectAppliedTableId)) {
      (success, returnData) = address(world).delegatecall(
        abi.encodeCall(
          world.registerTable,
          (
            EffectAppliedTableId,
            EffectApplied.getFieldLayout(),
            EffectApplied.getKeySchema(),
            EffectApplied.getValueSchema(),
            EffectApplied.getKeyNames(),
            EffectApplied.getFieldNames()
          )
        )
      );
      if (!success) revertWithBytes(returnData);
    }

    // Grant the hook access to the tables
    (success, returnData) = address(world).delegatecall(
      abi.encodeCall(world.grantAccess, (EffectDurationTableId, address(hook)))
    );
    if (!success) revertWithBytes(returnData);

    (success, returnData) = address(world).delegatecall(
      abi.encodeCall(world.grantAccess, (EffectTemplateTableId, address(hook)))
    );
    if (!success) revertWithBytes(returnData);

    (success, returnData) = address(world).delegatecall(
      abi.encodeCall(world.grantAccess, (EffectAppliedTableId, address(hook)))
    );
    if (!success) revertWithBytes(returnData);

    // Grant the hook access to external tables
    (success, returnData) = address(world).delegatecall(
      abi.encodeCall(world.grantAccess, (StatmodValueTableId, address(hook)))
    );
    if (!success) revertWithBytes(returnData);

    // Register a hook that is called when a value is deleted from the source table
    (success, returnData) = address(world).delegatecall(
      abi.encodeCall(world.registerStoreHook, (EffectDurationTableId, hook, BEFORE_DELETE_RECORD))
    );
  }

  function install(bytes memory) public pure {
    revert Module_NonRootInstallNotSupported();
  }
}
