// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibBaseInitAffix as b, Range, TargetLabel, DEFAULT_TIERS } from "./LibBaseInitAffix.sol";

import { StatmodTopic, StatmodTopics, StatmodOp, EleStat } from "../modules/statmod/StatmodTopic.sol";
import { EquipmentTypes } from "../equipment/EquipmentType.sol";

library LibInitEquipmentAffix {
  function init() internal {
    /*//////////////////////////////////////////////////////////////////////////
                                    RESOURCES
    //////////////////////////////////////////////////////////////////////////*/

    Range[DEFAULT_TIERS] memory resourceRanges = [Range(1, 4), Range(5, 6), Range(7, 9), Range(10, 12)];

    b.add(
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

    b.add(
      "life regen",
      StatmodTopics.LIFE_GAINED_PER_TURN.toStatmodEntity(StatmodOp.ADD, EleStat.NONE),
      resourceRanges,
      [
        b._explicits("Salubrious", "of Salubrity", _jewellery()),
        b._explicits("Recuperative", "of Recuperation", _jewellery()),
        b._explicits("Restorative", "of Restoration", _jewellery()),
        b._explicits("Rejuvenating", "of Rejuvenation", _jewellery())
      ]
    );

    b.add(
      "mana",
      StatmodTopics.MANA.toStatmodEntity(StatmodOp.ADD, EleStat.NONE),
      resourceRanges,
      [
        b._affixes(
          "Calm",
          "of Calm",
          _allEquipment(),
          _equipment(
            [
              "",
              "Student's Shield",
              "Student's Cap",
              "Student's Robe",
              "Student's Gloves",
              "Student's Pants",
              "Student's Boots",
              "Student's Necklace",
              "Student's Ring"
            ]
          )
        ),
        b._affixes(
          "Serene",
          "of Serenity",
          _allEquipment(),
          _equipment(
            [
              "",
              "Scholar's Shield",
              "Scholar's Cap",
              "Scholar's Robe",
              "Scholar's Gloves",
              "Scholar's Pants",
              "Scholar's Boots",
              "Scholar's Pendant",
              "Scholar's Ring"
            ]
          )
        ),
        b._affixes(
          "Tranquil",
          "of Tranquility",
          _allEquipment(),
          _equipment(
            [
              "",
              "Mage Shield",
              "Mage Hat",
              "Mage Vestment",
              "Mage Gloves",
              "Mage Pants",
              "Mage Boots",
              "Mage Amulet",
              "Mage Ring"
            ]
          )
        ),
        b._affixes(
          "Halcyon",
          "of Halcyon Mind",
          _allEquipment(),
          _equipment(
            [
              "",
              "Sage Shield",
              "Sage Circlet",
              "Sage Vestment",
              "Sage Gloves",
              "Sage Pants",
              "Sage Boots",
              "Sage Amulet",
              "Sage Signet"
            ]
          )
        )
      ]
    );

    b.add(
      "mana regen",
      StatmodTopics.MANA_GAINED_PER_TURN.toStatmodEntity(StatmodOp.ADD, EleStat.NONE),
      resourceRanges,
      [
        b._explicits("Drowsy", "of Drowsiness", _jewellery()),
        b._explicits("Sleepy", "of Sleepiness", _jewellery()),
        b._explicits("Slumberous", "of Slumber", _jewellery()),
        b._explicits("Somnolent", "of Somnolence", _jewellery())
      ]
    );

    /*//////////////////////////////////////////////////////////////////////////
                                      PSTATS
    //////////////////////////////////////////////////////////////////////////*/

    Range[DEFAULT_TIERS] memory pstatRanges = [Range(1, 1), Range(1, 2), Range(2, 3), Range(3, 4)];

    b.add(
      "strength",
      StatmodTopics.STRENGTH.toStatmodEntity(StatmodOp.ADD, EleStat.NONE),
      pstatRanges,
      [
        b._affixes(
          "Brutish",
          "of the Brute",
          _attrEquipment(),
          _equipment(["Wooden Club", "", "Headband", "", "", "", "", "Knucklebone Pendant", ""])
        ),
        b._affixes(
          "Canine",
          "of the Wolf",
          _attrEquipment(),
          _equipment(["Bronze Mace", "", "Wolf Pelt", "", "", "", "", "Wolfclaw Talisman", ""])
        ),
        b._affixes(
          "Bearish",
          "of the Bear",
          _attrEquipment(),
          _equipment(["Iron Mace", "", "Ursine Pelt", "", "", "", "", "Bearclaw Talisman", ""])
        ),
        b._affixes(
          "Lionheart",
          "of the Lion",
          _attrEquipment(),
          _equipment(["Steel Mace", "", "Lion Pelt", "", "", "", "", "Lionclaw Talisman", ""])
        )
      ]
    );

    b.add(
      "arcana",
      StatmodTopics.ARCANA.toStatmodEntity(StatmodOp.ADD, EleStat.NONE),
      pstatRanges,
      [
        b._affixes(
          "Studious",
          "of the Student",
          _attrEquipment(),
          _equipment(["Carved Wand", "", "Carved Circlet", "", "", "", "", "Carved Pendant", ""])
        ),
        b._affixes(
          "Observant",
          "of the Goat",
          _attrEquipment(),
          _equipment(["Goat's Horn", "", "Goat Skull Mask", "", "", "", "", "Goat Eye Talisman", ""])
        ),
        b._affixes(
          "Seercraft",
          "of the Seer",
          _attrEquipment(),
          _equipment(["Bone Wand", "", "Bone Circlet", "", "", "", "", "Bone Necklace", ""])
        ),
        b._affixes(
          "Mystical",
          "of Mysticism",
          _attrEquipment(),
          _equipment(["Mystic Wand", "", "Mystic Circlet", "", "", "", "", "Mystic Amulet", ""])
        )
      ]
    );

    b.add(
      "dexterity",
      StatmodTopics.DEXTERITY.toStatmodEntity(StatmodOp.ADD, EleStat.NONE),
      pstatRanges,
      [
        b._affixes(
          "Slick",
          "of the Mongoose",
          _attrEquipment(),
          _equipment(["Skinning Knife", "", "Skinning Cap", "", "", "", "", "Rabbit's Foot", ""])
        ),
        b._affixes(
          "Sly",
          "of the Fox",
          _attrEquipment(),
          _equipment(["Bronze Dagger", "", "Fox Pelt", "", "", "", "", "Fox Paw Talisman", ""])
        ),
        b._affixes(
          "Swift",
          "of the Falcon",
          _attrEquipment(),
          _equipment(["Iron Dagger", "", "Hunting Hood", "", "", "", "", "Feather Talisman", ""])
        ),
        b._affixes(
          "Agile",
          "of the Panther",
          _attrEquipment(),
          _equipment(["Steel Dagger", "", "Panther Pelt", "", "", "", "", "Pantherclaw Talisman", ""])
        )
      ]
    );

    /*//////////////////////////////////////////////////////////////////////////
                                      ATTACK
    //////////////////////////////////////////////////////////////////////////*/

    Range[DEFAULT_TIERS] memory weaponAttackRanges = [Range(1, 4), Range(5, 6), Range(7, 9), Range(10, 12)];

    b.add(
      "weapon base attack",
      StatmodTopics.ATTACK.toStatmodEntity(StatmodOp.BADD, EleStat.PHYSICAL),
      weaponAttackRanges,
      [
        b._affixes(
          "Burnished",
          "of Bruising",
          _weapon(),
          _equipment(["Bronze Shortsword", "", "", "", "", "", "", "", ""])
        ),
        b._affixes(
          "Polished",
          "of Striking",
          _weapon(),
          _equipment(["Bronze Falchion", "", "", "", "", "", "", "", ""])
        ),
        b._affixes("Honed", "of Harm", _weapon(), _equipment(["Iron Sword", "", "", "", "", "", "", "", ""])),
        b._affixes("Tempered", "of Assault", _weapon(), _equipment(["Steel Sword", "", "", "", "", "", "", "", ""]))
      ]
    );

    b.add(
      "weapon physical attack",
      StatmodTopics.ATTACK.toStatmodEntity(StatmodOp.ADD, EleStat.PHYSICAL),
      weaponAttackRanges,
      [
        b._affixes("Irate", "of Ire", _weapon(), _equipment(["Bronze Hatchet", "", "", "", "", "", "", "", ""])),
        b._affixes("Bullish", "of the Bull", _weapon(), _equipment(["Bronze Axe", "", "", "", "", "", "", "", ""])),
        b._affixes("Raging", "of Rage", _weapon(), _equipment(["Iron Battleaxe", "", "", "", "", "", "", "", ""])),
        b._affixes("Furious", "of Fury", _weapon(), _equipment(["Steel Battlexe", "", "", "", "", "", "", "", ""]))
      ]
    );

    b.add(
      "weapon fire attack",
      StatmodTopics.ATTACK.toStatmodEntity(StatmodOp.ADD, EleStat.FIRE),
      weaponAttackRanges,
      [
        b._affixes("Heated", "of Heat", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""])),
        b._affixes("Smouldering", "of Coals", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""])),
        b._affixes("Fiery", "of Fire", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""])),
        b._affixes("Flaming", "of Flames", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""]))
      ]
    );

    b.add(
      "weapon cold attack",
      StatmodTopics.ATTACK.toStatmodEntity(StatmodOp.ADD, EleStat.COLD),
      weaponAttackRanges,
      [
        b._affixes("Chilled", "of Chills", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""])),
        b._affixes("Icy", "of Ice", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""])),
        b._affixes("Cold", "of Cold", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""])),
        b._affixes("Frosted", "of Frost", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""]))
      ]
    );

    b.add(
      "weapon poison attack",
      StatmodTopics.ATTACK.toStatmodEntity(StatmodOp.ADD, EleStat.POISON),
      weaponAttackRanges,
      [
        b._affixes("Sickly", "of Sickness", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""])),
        b._affixes("Poisonous", "of Poison", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""])),
        b._affixes("Venomous", "of Venom", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""])),
        b._affixes("Malignant", "of Malignancy", _weapon(), _equipment(["", "", "", "", "", "", "", "", ""]))
      ]
    );

    /*//////////////////////////////////////////////////////////////////////////
                                      RESISTANCE
    //////////////////////////////////////////////////////////////////////////*/

    Range[DEFAULT_TIERS] memory resistanceMinorRanges = [Range(1, 3), Range(3, 5), Range(5, 6), Range(6, 7)];

    b.add(
      "physical resistance",
      StatmodTopics.RESISTANCE.toStatmodEntity(StatmodOp.ADD, EleStat.PHYSICAL),
      resistanceMinorRanges,
      [
        b._affixes(
          "Toughened",
          "of the Oyster",
          _resEquipment(),
          _equipment(
            [
              "",
              "Banded Shield",
              "Battered Helmet",
              "Rusted Armor",
              "Rusted Bracers",
              "Rusted Legguard",
              "Rusted Boots",
              "",
              ""
            ]
          )
        ),
        b._affixes(
          "Sturdy",
          "of the Lobster",
          _resEquipment(),
          _equipment(
            [
              "",
              "Bronze Shield",
              "Bronze Helmet",
              "Bronze Vest",
              "Bronze Bracers",
              "Bronze Legguards",
              "Bronze Boots",
              "",
              ""
            ]
          )
        ),
        b._affixes(
          "Reinforced",
          "of the Nautilus",
          _resEquipment(),
          _equipment(
            ["", "Iron Shield", "Iron Helmet", "Iron Plate", "Iron Gauntlets", "Iron Legguards", "Iron Greaves", "", ""]
          )
        ),
        b._affixes(
          "Fortified",
          "of the Tortoise",
          _resEquipment(),
          _equipment(
            [
              "",
              "Steel Shield",
              "Steel Helmet",
              "Steel Plate",
              "Steel Gauntlets",
              "Steel Legguards",
              "Steel Greaves",
              "",
              ""
            ]
          )
        )
      ]
    );
  }

  /*//////////////////////////////////////////////////////////////////////////
                              EQUIPMENT PROTOTYPES
  //////////////////////////////////////////////////////////////////////////*/

  function _allEquipment() internal pure returns (bytes32[] memory r) {
    r = new bytes32[](9);
    r[0] = EquipmentTypes.WEAPON.toBytes32();
    r[1] = EquipmentTypes.SHIELD.toBytes32();
    r[2] = EquipmentTypes.HAT.toBytes32();
    r[3] = EquipmentTypes.CLOTHING.toBytes32();
    r[4] = EquipmentTypes.GLOVES.toBytes32();
    r[5] = EquipmentTypes.PANTS.toBytes32();
    r[6] = EquipmentTypes.BOOTS.toBytes32();
    r[7] = EquipmentTypes.AMULET.toBytes32();
    r[8] = EquipmentTypes.RING.toBytes32();
  }

  function _jewellery() internal pure returns (bytes32[] memory r) {
    r = new bytes32[](2);
    r[0] = EquipmentTypes.AMULET.toBytes32();
    r[1] = EquipmentTypes.RING.toBytes32();
  }

  function _attrEquipment() internal pure returns (bytes32[] memory r) {
    r = new bytes32[](4);
    r[0] = EquipmentTypes.WEAPON.toBytes32();
    r[1] = EquipmentTypes.SHIELD.toBytes32();
    r[2] = EquipmentTypes.HAT.toBytes32();
    r[3] = EquipmentTypes.AMULET.toBytes32();
  }

  function _weapon() internal pure returns (bytes32[] memory r) {
    r = new bytes32[](1);
    r[0] = EquipmentTypes.WEAPON.toBytes32();
  }

  function _resEquipment() internal pure returns (bytes32[] memory r) {
    r = new bytes32[](6);
    r[0] = EquipmentTypes.SHIELD.toBytes32();
    r[1] = EquipmentTypes.HAT.toBytes32();
    r[2] = EquipmentTypes.CLOTHING.toBytes32();
    r[3] = EquipmentTypes.GLOVES.toBytes32();
    r[4] = EquipmentTypes.PANTS.toBytes32();
    r[5] = EquipmentTypes.BOOTS.toBytes32();
  }

  function _equipment(string[9] memory _labels) internal pure returns (TargetLabel[] memory _dynamic) {
    bytes32[] memory allEquipment = _allEquipment();

    _dynamic = new TargetLabel[](_labels.length);
    uint256 j;
    for (uint256 i; i < _labels.length; i++) {
      if (bytes(_labels[i]).length > 0) {
        _dynamic[j] = TargetLabel({ targetEntity: allEquipment[i], label: _labels[i] });
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
