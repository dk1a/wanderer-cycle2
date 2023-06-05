// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { MudV2Test } from "@latticexyz/std-contracts/src/test/MudV2Test.t.sol";
import { LibGuiseLevel } from "../src/guise/LibGuiseLevel.sol";
import { LibExperience } from "../src/charstat/LibExperience.sol";
import { ActiveGuise } from "../src/codegen/Tables.sol";
import { GuisePrototype } from "../src/codegen/Tables.sol";
import { PStat_length } from "../src/CustomTypes.sol";

contract LibGuiseLevelTest is MudV2Test {
  bytes32 internal targetEntity = keccak256("targetEntity");
  uint32[PStat_length] addExp;
  uint32[PStat_length] levelMul;

  function setUp() public virtual override {
    super.setUp();
    vm.startPrank(worldAddress);
  }

  function initializeValue(
    uint32[PStat_length] memory _addExp,
    uint32[PStat_length] memory _levelMul,
    bytes32 targetEntity
  ) public {
    // Initialize exp and levelMul
    LibExperience.initExp(targetEntity);
    addExp = _addExp;
    levelMul = _levelMul;

    LibExperience.increaseExp(targetEntity, addExp);
    uint256 guiseProtoEntity = ActiveGuise.get(targetEntity);
    GuisePrototype.set(bytes32(guiseProtoEntity), levelMul);
  }

  function testGetAggregateLevel() public {
    initializeValue([uint32(1), 1, 1], [uint32(2), 2, 2], targetEntity);
    uint32 aggregateLevel = LibGuiseLevel.getAggregateLevel(bytes32(targetEntity));
    assertEq(aggregateLevel, 1); // expected 1 = (2*1 + 2*1 + 2*1) / (2 + 2 + 2)
  }

  function testFuzzGetAggregateLevel(uint32[PStat_length] memory addExp, uint32[PStat_length] memory levelMul) public {
    for (uint32 i = 0; i < PStat_length; i++) {
      vm.assume(addExp[i] > 0);
      vm.assume(levelMul[i] > 0);
    }
    initializeValue(addExp, levelMul, targetEntity);
    uint32 aggregateLevel = LibGuiseLevel.getAggregateLevel(bytes32(targetEntity));

    // TODO make a proper comparison
    assertEq(aggregateLevel, 2);
  }

  function testMultiplyExperience() public {
    initializeValue([uint32(1), 1, 1], [uint32(2), 2, 2], targetEntity);
    uint32[PStat_length] memory expMultiplied = LibGuiseLevel.multiplyExperience(targetEntity, addExp);
    for (uint256 i; i < expMultiplied.length; i++) {
      assertEq(expMultiplied[i], 2);
    }
  }
}
