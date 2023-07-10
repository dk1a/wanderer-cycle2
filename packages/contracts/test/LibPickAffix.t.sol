// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { MudV2Test } from "@latticexyz/std-contracts/src/test/MudV2Test.t.sol";
import { LibPickAffixes } from "../src/affix/LibPickAffix.sol";

contract LibPickAffixesTest is MudV2Test {
  bytes32 internal targetEntity = keccak256("targetEntity");

  function testPickAffixes() public {
    // Initializing fake data for the test
    AffixPartId[] memory affixPartIds = new AffixPartId[](2);
    affixPartIds[0] = AffixPartId.PREFIX;
    affixPartIds[1] = AffixPartId.SUFFIX;

    uint32[] memory excludeAffixes = new uint32[](0);

    bytes32[] memory availableEntities = new bytes32[](3);
    availableEntities[0] = keccak256("affix1");
    availableEntities[1] = keccak256("affix2");
    availableEntities[2] = keccak256("affix3");

    // Create fake data and marking library functions
    LibPickAffixes.AffixPrototypeData memory affixProto = LibPickAffixes.AffixPrototypeData({
      statmodProtoEntity: bytes32(0x123),
      tier: 1,
      requiredIlvl: 1,
      min: 1,
      max: 10
    });

    // call pickAffixes
    (
      bytes32[] memory statmodProtoEntities,
      bytes32[] memory affixProtoEntities,
      uint32[] memory affixValues
    ) = LibPickAffixes.pickAffixes(affixPartIds, excludeAffixes, targetEntity, 1, 123);

    // Checking the results of the pickAffixes function
    assertEq(statmodProtoEntities.length, 2);
    assertEq(affixProtoEntities.length, 2);
    assertEq(affixValues.length, 2);

    assertEq(statmodProtoEntities[0], bytes32(0x123));
    assertEq(statmodProtoEntities[1], bytes32(0x123));

    assertEq(affixProtoEntities[0], availableEntities[0]);
    assertEq(affixProtoEntities[1], availableEntities[1]);

    assertEq(affixValues[0], 6);
    assertEq(affixValues[1], 7);
  }

  function testManuallyPickAffixesMax() public {
    // Initializing fake data for the test
    string[] memory names = new string[](2);
    names[0] = "affix1";
    names[1] = "affix2";

    uint32[] memory tiers = new uint32[](2);
    tiers[0] = 1;
    tiers[1] = 2;

    // Call manuallyPickAffixesMax
    (
      uint32[] memory statmodProtoEntities,
      uint32[] memory affixProtoEntities,
      uint32[] memory affixValues
    ) = LibPickAffixes.manuallyPickAffixesMax(names, tiers);

    // Checking the results of the manuallyPickAffixesMax
    assertEq(statmodProtoEntities.length, 2);
    assertEq(affixProtoEntities.length, 2);
    assertEq(affixValues.length, 2);
  }

  function testPickAffixValue() public {
    // Initializing fake data for the test
    LibPickAffixes.AffixPrototypeData memory affixProto = LibPickAffixes.AffixPrototypeData({
      statmodProtoEntity: bytes32(0x123),
      tier: 1,
      requiredIlvl: 1,
      min: 1,
      max: 10
    });

    // call pickAffixValue
    uint32 affixValue = LibPickAffixes._pickAffixValue(affixProto, 123);

    // Checking the results of the pickAffixValue
    assertEq(affixValue, 6);
  }
}
