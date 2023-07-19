// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";

import { IBaseWorld } from "@latticexyz/world/src/interfaces/IBaseWorld.sol";
import { IModule } from "@latticexyz/world/src/interfaces/IModule.sol";

import { getTargetTableSelector } from "@latticexyz/world/src/modules/utils/getTargetTableSelector.sol";
import { MODULE_NAMESPACE, MODULE_NAME } from "./constants.sol";
import { Duration } from "../codegen/tables/Duration.sol";

contract DurationModule is IModule, WorldContext {
  function getName() public pure returns (bytes16) {
    return MODULE_NAME;
  }

  function install(bytes memory args) public override {
    // Extract source table id from args
    bytes32 sourceTableId = abi.decode(args, (bytes32));
    bytes32 targetTableSelector = getTargetTableSelector(MODULE_NAMESPACE, sourceTableId);

    // Register the target table
    IBaseWorld(_world()).registerTable(
      targetTableSelector.getNamespace(),
      targetTableSelector.getName(),
      Duration.getSchema(),
      Duration.getKeySchema()
    );

    // Register metadata for the target table
    (string memory tableName, string[] memory fieldNames) = Duration.getMetadata();
    IBaseWorld(_world()).setMetadata(
      targetTableSelector.getNamespace(),
      targetTableSelector.getName(),
      tableName,
      fieldNames
    );
  }
}
