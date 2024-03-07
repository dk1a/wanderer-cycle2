// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { MudLibTest } from "./MudLibTest.t.sol";
import { LibPickAffixes } from "../src/affix/LibPickAffix.sol";
import { AffixPartId } from "../src/codegen/common.sol";
import { AffixPrototype, AffixPrototypeData } from "../src/codegen/index.sol";

contract LibPickAffixesTest is MudLibTest {
  bytes32 internal targetEntity = keccak256("targetEntity");

  function setUp() public {
    super.setUp();
  }

  function testPickAffixes() public {
    AffixPartId[] memory affixPartIds = new AffixPartId[](2);
    affixPartIds[0] = AffixPartId.PREFIX;
    affixPartIds[1] = AffixPartId.SUFFIX;

    uint32[] memory excludeAffixes = new uint32[](0);

    bytes32[] memory availableEntities = new bytes32[](3);
    availableEntities[0] = keccak256("affix1");
    availableEntities[1] = keccak256("affix2");
    availableEntities[2] = keccak256("affix3");

    (
      bytes32[] memory statmodProtoEntities,
      bytes32[] memory affixProtoEntities,
      uint32[] memory affixValues
    ) = LibPickAffixes.pickAffixes(affixPartIds, excludeAffixes, targetEntity, 1, 123);

    assertEq(statmodProtoEntities.length, 2);
    assertEq(affixProtoEntities.length, 2);
    assertEq(affixValues.length, 2);
  }

  function testManuallyPickAffixesMax() public {
    string[] memory names = new string[](2);
    names[0] = "affix1";
    names[1] = "affix2";

    uint32[] memory tiers = new uint32[](2);
    tiers[0] = 1;
    tiers[1] = 2;

    (
      uint32[] memory statmodProtoEntities,
      uint32[] memory affixProtoEntities,
      uint32[] memory affixValues
    ) = LibPickAffixes.manuallyPickAffixesMax(names, tiers);

    assertEq(statmodProtoEntities.length, 2);
    assertEq(affixProtoEntities.length, 2);
    assertEq(affixValues.length, 2);
  }

  // To test this function, we will need to make it accessible by making it public/external
  // or by adding a public/external function that calls it
  // function testPickAffixValue() public {
  //   // Initializing fake data for the test
  //   AffixPrototypeData memory affixProto = LibPickAffixes.AffixPrototypeData({
  //     statmodProtoEntity: bytes32(0x123),
  //     tier: 1,
  //     requiredIlvl: 1,
  //     min: 1,
  //     max: 10
  //   });

  //   // call pickAffixValue
  //   uint32 affixValue = LibPickAffixes._pickAffixValue(affixProto, 123);

  //   // Checking the results of the pickAffixValue
  //   assertEq(affixValue, 6);
  // }
}
