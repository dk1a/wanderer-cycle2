// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

/**
 * @title IWandererSpawnSystem
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IWandererSpawnSystem {
  error WandererSpawn_InvalidGuise();

  function spawnWanderer(bytes32 guiseEntity) external returns (bytes32 wandererEntity, bytes32 cycleEntity);
}
