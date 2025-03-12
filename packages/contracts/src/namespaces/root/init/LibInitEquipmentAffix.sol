// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { getUniqueEntity } from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";

import { StatmodTopics } from "../../statmod/StatmodTopic.sol";

import { AffixAvailabilityTargetId, LibAffixParts as b } from "../../affix/LibAffixParts.sol";
import { LibAddAffixPrototype } from "../../affix/LibAddAffixPrototype.sol";
import { AffixPart, Range, TargetLabel } from "../../affix/types.sol";
import { DEFAULT_TIERS } from "../../affix/constants.sol";

import { LibLootMint } from "../loot/LibLootMint.sol";

import { EquipmentAffixAvailabilityTargetIds as EAATIds } from "../equipment/EquipmentAffixAvailabilityTargetIds.sol";
import { EquipmentType, EquipmentTypes } from "../equipment/EquipmentType.sol";

import { StatmodOp, EleStat } from "../../../codegen/common.sol";

import { EquipmentTypeComponent } from "../codegen/index.sol";

library LibInitEquipmentAffix {
  function init() internal {
    /*//////////////////////////////////////////////////////////////////////////
                                    RESOURCES
    //////////////////////////////////////////////////////////////////////////*/

    Range[DEFAULT_TIERS] memory resourceRanges = [Range(1, 4), Range(5, 6), Range(7, 9), Range(10, 12)];

    add(
      "life",
      StatmodTopics.LIFE.toStatmodEntity(StatmodOp.ADD, EleStat.NONE),
      resourceRanges,
      [
        b._affixes(
          "Hale",
          "of Haleness",
          _allEquipment(),
          _equipment(
            [
              "",
              "Brawler's Shield",
              "Brawler's Headband",
              "Brawler's Vest",
              "Brawler's Bracers",
              "Brawler's Pants",
              "Brawler's Boots",
              "Brawler's Necklace",
              "Brawler's Ring"
            ]
          )
        ),
        b._affixes(
          "Healthful",
          "of Health",
          _allEquipment(),
          _equipment(
            [
              "",
              "Infantry Shield",
              "Infantry Helmet",
              "Infantry Brigandine",
              "Infantry Gloves",
              "Infantry Trousers",
              "Infantry Boots",
              "Infantry Pendant",
              "Infantry Ring"
            ]
          )
        ),
        b._affixes(
          "Robust",
          "of Robustness",
          _allEquipment(),
          _equipment(
            [
              "",
              "Warrior Shield",
              "Warrior Helmet",
              "Warrior Armor",
              "Warrior Gauntlets",
              "Warrior Legguards",
              "Warrior Greaves",
              "Warrior Amulet",
              "Warrior Ring"
            ]
          )
        ),
        b._affixes(
          "Stalwart",
          "of Stalwart Body",
          _allEquipment(),
          _equipment(
            [
              "",
              "Crusader Shield",
              "Crusader Helmet",
              "Crusader Plate",
              "Crusader Gauntlets",
              "Crusader Legguards",
              "Crusader Greaves",
              "Crusader Amulet",
              "Crusader Signet"
            ]
          )
        )
      ]
    );
  }

  function add(
    string memory affixPrototypeName,
    bytes32 statmodBaseEntity,
    Range[DEFAULT_TIERS] memory ranges,
    AffixPart[][DEFAULT_TIERS] memory tieredAffixParts
  ) internal {
    // TODO separate exclusiveGroup from name when it becomes more relevant
    bytes32 exclusiveGroup = bytes32(bytes(affixPrototypeName));
    LibAddAffixPrototype.addAffixPrototypes(
      affixPrototypeName,
      statmodBaseEntity,
      exclusiveGroup,
      ranges,
      tieredAffixParts
    );
  }

  /*//////////////////////////////////////////////////////////////////////////
                              EQUIPMENT TYPES
  //////////////////////////////////////////////////////////////////////////*/

  function _allEquipment() internal pure returns (AffixAvailabilityTargetId[] memory targetIds) {
    targetIds = new AffixAvailabilityTargetId[](9);
    targetIds[0] = EAATIds.WEAPON;
    targetIds[1] = EAATIds.SHIELD;
    targetIds[2] = EAATIds.HAT;
    targetIds[3] = EAATIds.CLOTHING;
    targetIds[4] = EAATIds.GLOVES;
    targetIds[5] = EAATIds.PANTS;
    targetIds[6] = EAATIds.BOOTS;
    targetIds[7] = EAATIds.AMULET;
    targetIds[8] = EAATIds.RING;
  }

  function _jewellery() internal pure returns (AffixAvailabilityTargetId[] memory targetIds) {
    targetIds = new AffixAvailabilityTargetId[](2);
    targetIds[0] = EAATIds.AMULET;
    targetIds[1] = EAATIds.RING;
  }

  function _attrEquipment() internal pure returns (AffixAvailabilityTargetId[] memory targetIds) {
    targetIds = new AffixAvailabilityTargetId[](4);
    targetIds[0] = EAATIds.WEAPON;
    targetIds[1] = EAATIds.SHIELD;
    targetIds[2] = EAATIds.HAT;
    targetIds[3] = EAATIds.AMULET;
  }

  function _weapon() internal pure returns (AffixAvailabilityTargetId[] memory targetIds) {
    targetIds = new AffixAvailabilityTargetId[](1);
    targetIds[0] = EAATIds.WEAPON;
  }

  function _resEquipment() internal pure returns (AffixAvailabilityTargetId[] memory targetIds) {
    targetIds = new AffixAvailabilityTargetId[](6);
    targetIds[0] = EAATIds.SHIELD;
    targetIds[1] = EAATIds.HAT;
    targetIds[2] = EAATIds.CLOTHING;
    targetIds[3] = EAATIds.GLOVES;
    targetIds[4] = EAATIds.PANTS;
    targetIds[5] = EAATIds.BOOTS;
  }

  function _equipment(string[9] memory _labels) internal pure returns (TargetLabel[] memory _dynamic) {
    AffixAvailabilityTargetId[] memory allEquipment = _allEquipment();

    _dynamic = new TargetLabel[](_labels.length);
    uint256 j;
    for (uint256 i; i < _labels.length; i++) {
      if (bytes(_labels[i]).length > 0) {
        _dynamic[j] = TargetLabel({ affixAvailabilityTargetId: allEquipment[i], label: _labels[i] });
        j++;
      }
    }
    // shorten dynamic length if necessary
    if (_labels.length != j) {
      /// @solidity memory-safe-assembly
      assembly {
        mstore(_dynamic, j)
      }
    }
  }
}
