// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { System } from "@latticexyz/world/src/System.sol";

import { ActiveCycle } from "../codegen/index.sol";

import { LibCycleTurns } from "./LibCycleTurns.sol";

// import { LibToken } from "../token/LibToken.sol";

/// @title Claim accumulated cycle turns.
/// @dev Does nothing if claimable turns == 0.
contract ClaimCycleTurnsSystem is System {
  function claimCycleTurnsSystem(bytes memory args) public override returns (bytes memory) {
    bytes32 wandererEntity = abi.decode(args, (bytes32));
    // check permission
    // LibToken.requireOwner(wandererEntity, msg.sender);
    // get cycle entity
    bytes32 cycleEntity = ActiveCycle.get(wandererEntity);
    // claim
    LibCycleTurns.claimTurns(cycleEntity);

    return "";
  }
}
