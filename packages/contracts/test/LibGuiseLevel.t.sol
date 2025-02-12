// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibGuiseLevel } from "../src/namespaces/root/guise/LibGuiseLevel.sol";
import { LibExperience } from "../src/namespaces/root/charstat/LibExperience.sol";
import { ActiveGuise, GuisePrototype } from "../src/namespaces/root/codegen/index.sol";
import { PStat_length } from "../src/CustomTypes.sol";
import { MudLibTest } from "./MudLibTest.t.sol";

contract LibGuiseLevelTest is MudLibTest {
  bytes32 internal targetEntity = keccak256("targetEntity");
  uint32[PStat_length] internal levelMul = [8, 8, 8];

  // Initialize exp and levelMul
  function _init(uint32[PStat_length] memory addExp) internal {
    LibExperience.initExp(targetEntity);
    LibExperience.increaseExp(targetEntity, addExp);

    bytes32 guiseProtoEntity = ActiveGuise.get(targetEntity);
    GuisePrototype.set(guiseProtoEntity, levelMul);
  }

  function testGetAggregateLevel() public {
    _init([uint32(1), 1, 1]);

    uint32 aggregateLevel = LibGuiseLevel.getAggregateLevel(bytes32(targetEntity));
    // expected 1 = (8*1 + 8*1 + 8*1) / (8 + 8 + 8)
    assertEq(aggregateLevel, 1);
  }

  function testFuzzGetAggregateLevel(uint32[PStat_length] memory addExp) public {
    _init(addExp);
    uint32 aggregateLevel = LibGuiseLevel.getAggregateLevel(bytes32(targetEntity));

    uint256 expTotal;
    uint256 levelMulTotal;
    for (uint256 i; i < addExp.length; i++) {
      expTotal += uint256(addExp[i]) * uint256(levelMul[i]);
      levelMulTotal += uint256(levelMul[i]);
    }

    assertEq(aggregateLevel, LibExperience._getLevel(expTotal / levelMulTotal));
  }

  function testMultiplyExperience() public {
    uint32[PStat_length] memory addExp = [uint32(1), 1, 1];
    _init(addExp);

    uint32[PStat_length] memory expMultiplied = LibGuiseLevel.multiplyExperience(targetEntity, addExp);
    for (uint256 i; i < expMultiplied.length; i++) {
      assertEq(expMultiplied[i], levelMul[i]);
    }
  }
}
