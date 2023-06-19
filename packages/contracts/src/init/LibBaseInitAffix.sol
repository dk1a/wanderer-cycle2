// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { Name } from "../codegen/Tables.sol";
import { StatmodBase, FromStatmodBase, StatmodBaseOpts, StatmodBaseOptsData, StatmodScope, StatmodValue } from "../codegen/Tables.sol";
import { AffixAvailable, AffixNaming, AffixPrototype, AffixPrototypeData, AffixProtoIndex, AffixProtoGroup, Affix, AffixData } from "../codegen/Tables.sol";

import { AffixPartId } from "../codegen/Types.sol";

struct AffixPart {
  AffixPartId partId;
  bytes32 targetEntity;
  string label;
}

/// @dev affix value range
struct Range {
  uint32 min;
  uint32 max;
}

/// @dev target label
struct TargetLabel {
  bytes32 targetEntity;
  string label;
}

/// @dev number of usually expected tiers (some affixes may have non-standard tiers)
uint32 constant DEFAULT_TIERS = 4;
/// @dev number of currently expected ilvls
uint32 constant MAX_ILVL = 16;

/// @dev Default ilvl requirement based on affix tier.
/// (affixes with non-standard tiers shouldn't use this function)
function tierToDefaultRequiredIlvl(uint32 tier) pure returns (uint32 requiredIlvl) {
  // `tier` is not user-submitted, the asserts should never fail
  assert(tier > 0);
  assert(tier <= type(uint32).max);

  return (uint32(tier) - 1) * 4 + 1;
}

/// @dev Affixes have a complex structure, however most complexity is shoved into this BaseInit,
/// so the child inits and affix components are relatively simple.
///
/// Each affix has: name, associated statmod, tier.
/// Affixes with the same name (but different tiers) are grouped together via `AffixPrototypeGroupComponent`.
///
/// Tiers are 1,2,3,4..., higher means better affixes (tiers can be skipped).
/// Each affix's tier has 1 min-max range and a set of affix parts.
/// Each set of affix parts has:
///   2 explicits: prefix, suffix
///   1 implicit
/// Parts have labels. Explicits' labels don't depend on targets. Implicits' label do.
/// affix => tier => {prefixLabel, suffixLabel}
/// affix => tier => targetEntity => implicitLabel
/// (targetEntity is e.g. equipmentProtoEntity)
library LibBaseInitAffix {
  error LibBaseInitAffix__MalformedInput(string affixName, uint32 maxIlvl);
  error LibBaseInitAffix__InvalidStatmodPrototype();

  /// @dev Add `DEFAULT_TIERS` tiers of an affix
  /// (for affixes with non-standard tiers use `addOne` directly)
  function add(
    string memory affixName,
    bytes32 statmodProtoEntity,
    Range[DEFAULT_TIERS] memory ranges,
    AffixPart[][DEFAULT_TIERS] memory tieredAffixParts
  ) internal {
    for (uint32 i; i < tieredAffixParts.length; i++) {
      uint32 tier = i + 1;

      AffixPart[] memory affixParts = tieredAffixParts[i];
      if (affixParts.length == 0) continue;
      Range memory range = ranges[i];

      AffixPrototype memory proto = AffixPrototype({
        tier: tier,
        statmodProtoEntity: statmodProtoEntity,
        requiredIlvl: tierToDefaultRequiredIlvl(tier),
        min: range.min,
        max: range.max
      });

      addOne(affixName, proto, affixParts);
    }
  }

  /// @dev Add a single affix tier with *default* maxIlvl
  function addOne(
    string memory affixName,
    AffixPrototypeData memory affixProto,
    AffixPart[] memory affixParts
  ) internal {
    addOne(affixName, affixProto, affixParts, MAX_ILVL);
  }

  /// @dev Add a single affix tier with *custom* maxIlvl
  function addOne(
    string memory affixName,
    AffixPrototypeData memory affixProto,
    AffixPart[] memory affixParts,
    uint32 maxIlvl
  ) internal {
    if (maxIlvl == 0 || affixProto.requiredIlvl > maxIlvl) {
      revert LibBaseInitAffix__MalformedInput(affixName, maxIlvl);
    }
    if (affixProto.statmodProtoEntity == 0) {
      revert LibBaseInitAffix__InvalidStatmodPrototype();
    }

    bytes32 protoEntity = AffixProtoIndex.get(affixName, affixProto.tier);
    AffixPrototype.set(protoEntity, affixProto);
    Name.set(protoEntity, affixName);
    //TODO work on types
    AffixProtoGroup.set(protoEntity, AffixProtoGroup.get(affixName));

    for (uint256 i; i < affixParts.length; i++) {
      AffixPartId partId = affixParts[i].partId;
      bytes32 targetEntity = affixParts[i].targetEntity;
      string memory label = affixParts[i].label;

      // which (partId+target) the affix is available for.
      // affixProto => target => AffixPartId => label
      bytes32 namingEntity = AffixNaming.get(partId, targetEntity, protoEntity);
      Name.set(namingEntity, label);

      // availability component is basically a cache,
      // all its data is technically redundant, but greatly simplifies and speeds up queries.
      // target => partId => range(requiredIlvl, maxIlvl) => Set(affixProtos)
      for (uint32 ilvl = affixProto.requiredIlvl; ilvl <= maxIlvl; ilvl++) {
        uint256 availabilityEntity = AffixAvailable.getItem(partId, targetEntity, ilvl, i);
        AffixAvailable.push(partId, protoEntity, ilvl, availabilityEntity);
      }
    }
  }
}
