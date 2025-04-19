// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { PStat_length } from "../../CustomTypes.sol";

/**
 * @title ICharstatSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface ICharstatSystem {
  error CharstatSystem_ExpNotInitialized();

  function charstat__setLifeCurrent(bytes32 targetEntity, uint32 value) external;

  function charstat__setManaCurrent(bytes32 targetEntity, uint32 value) external;

  function charstat__setFullCurrents(bytes32 targetEntity) external;

  function charstat__initExp(bytes32 targetEntity) external;

  function charstat__increaseExp(bytes32 targetEntity, uint32[PStat_length] memory addExp) external;
}
