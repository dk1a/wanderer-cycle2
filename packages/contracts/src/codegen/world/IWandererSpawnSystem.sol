// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface IWandererSpawnSystem {
  error WandererSpawnSystem__InvalidGuise();

  function executeTyped(bytes32 guiseProtoEntity) external returns (bytes32 wandererEntity);

  function execute(bytes memory args) external returns (bytes memory);
}
