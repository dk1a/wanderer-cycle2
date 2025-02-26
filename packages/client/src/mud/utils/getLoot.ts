import {
  Entity,
  getComponentValueStrict,
  hasComponent,
} from "@latticexyz/recs";
// import { getEffectPrototype } from "./getEffect";
// import {AffixPartId, getLootAffixes, LootAffix} from "./getLootAffix";
import { SetupResult } from "../setup";

type GetLootComponents = SetupResult["components"];

export function getLoot(components: GetLootComponents, entity: Entity) {
  const {
    Name,
    LootIlvl,
    FromTemplate,
    // EffectTemplate,
    // AffixNaming,
    // AffixPrototype
  } = components;

  const lootIlvl = getComponentValueStrict(LootIlvl, entity);
  const protoEntity = getComponentValueStrict(FromTemplate, entity);
  if (!protoEntity) {
    throw new Error("No loot prototype entity found");
  }
  // const effect = getEffectPrototype(EffectPrototype, entity);
  // if (effect === undefined) {
  //   throw new Error(`No effect for loot ${entity}`);
  // }

  // const affixes = getLootAffixes(
  //   { Name, AffixNaming, AffixPrototype },
  //   protoEntity,
  //   // loot.affixPartIds,
  //   // loot.affixProtoEntities,
  //   // loot.affixValues,
  //   // effect.statmods
  // );

  let name: string;
  if (hasComponent(Name, entity)) {
    name = getComponentValueStrict(Name, entity).value;
  } else {
    //   name = getNameFromAffixes(affixes);
    return "";
  }

  return {
    entity,
    name,
    ilvl: lootIlvl,
    // affixes,
    // effect,
    protoEntity,
  };
}

// function getNameFromAffixes(affixes: LootAffix[]) {
//   const implicits = affixes.filter(({ partId }) => partId === AffixPartId.IMPLICIT);
//   const prefixes = affixes.filter(({ partId }) => partId === AffixPartId.PREFIX);
//   const suffixes = affixes.filter(({ partId }) => partId === AffixPartId.SUFFIX);
//   const ordered = prefixes.reverse().concat(implicits).concat(suffixes);
//   return ordered.map(({ naming }) => naming).join(" ");
// }
