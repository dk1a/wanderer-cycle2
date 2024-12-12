// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

/**
 * @title ICompleteCycleSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface ICompleteCycleSystem {
  error CompleteCycleSystem__NotAllBossesDefeated();
  error CompleteCycleSystem__InsufficientLevel();

  function complete(bytes memory args) external returns (bytes memory);
}