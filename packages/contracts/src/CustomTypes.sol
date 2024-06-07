// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { StatmodOp, EleStat } from "./codegen/common.sol";

enum PStat {
  STRENGTH,
  ARCANA,
  DEXTERITY
}

string constant wandererTokenName = "wanderer-cycle non-fungible tokens";
string constant wandererTokenSymbol = "WNFT";
string constant wandererTokenURI = "";

uint256 constant PStat_length = 3;

uint256 constant StatmodOp_length = 3;

uint256 constant EleStat_length = 5;

StatmodOp constant StatmodOpFinal = StatmodOp.ADD;
