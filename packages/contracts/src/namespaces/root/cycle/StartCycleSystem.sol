// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { System } from "@latticexyz/world/src/System.sol";

import { LibCycle } from "./LibCycle.sol";
import { ERC721Namespaces } from "../token/ERC721Namespaces.sol";

/// @title Start a cycle.
/// @dev Very much like WandererSpawnSystem, but for an existing wandererEntity.
contract StartCycleSystem is System {
  function startCycle(
    bytes32 wandererEntity,
    bytes32 guiseProtoEntity,
    bytes32 wheelEntity
  ) public returns (bytes32 cycleEntity) {
    // check permission
    ERC721Namespaces.WandererNFT.requireOwner(_msgSender(), wandererEntity);
    // init cycle (reverts if a cycle is already active)
    cycleEntity = LibCycle.initCycle(wandererEntity, guiseProtoEntity, wheelEntity);
  }
}
