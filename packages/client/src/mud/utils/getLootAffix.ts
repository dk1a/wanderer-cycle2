// import { Entity, getComponentValueStrict, World } from "@latticexyz/recs";
// import { defaultAbiCoder, keccak256, toUtf8Bytes } from "ethers";
// import { SetupResult } from "../setup";
// import { EffectStatmodData } from "./effectStatmod";
//
// export enum AffixPartId {
//   IMPLICIT,
//   PREFIX,
//   SUFFIX,
// }
//
// export interface LootAffix {
//   naming: string;
//   partId: AffixPartId;
//   protoEntity: Entity;
//   value: number;
//   statmod: EffectStatmodData;
//   affixPrototype: ReturnType<typeof getAffixPrototype>;
// }
//
// type GetLootAffixComponents = Pick<SetupResult["components"], "Name" | "AffixNaming" | "AffixPrototype">;
//
// export function getLootAffixes(
//   world: World,
//   components: GetLootAffixComponents,
//   lootProtoEntityId: Entity,
//   partIds: number[],
//   affixProtoEntityIds: Entity[],
//   values: number[],
//   statmods: EffectStatmodData[]
// ) {
//   const lootAffixes: LootAffix[] = [];
//
//   if (statmods.length !== affixProtoEntityIds.length) {
//     throw new Error("Affixes and statmods length mismatch");
//   }
//
//   for (let i = 0; i < affixProtoEntityIds.length; i++) {
//     lootAffixes.push(
//       getLootAffix(world, components, lootProtoEntityId, partIds[i], affixProtoEntityIds[i], values[i], statmods[i])
//     );
//   }
//
//   return lootAffixes;
// }
//
// const affixNamingComponentId = keccak256(toUtf8Bytes("component.AffixNaming"));
//
// export function getLootAffix(
//   world: World,
//   components: GetLootAffixComponents,
//   lootProtoEntityId: Entity,
//   partId: number,
//   affixProtoEntity: Entity,
//   value: number,
//   statmod: EffectStatmodData
// ): LootAffix {
//   const { AffixNaming } = components;
//   if (affixProtoEntity === undefined) {
//     throw new Error(`affix prototype entity index not found for id ${affixProtoEntity}`);
//   }
//
//   const affixNamingEntityId = keccak256(
//     defaultAbiCoder.encode(
//       ["uint256", "uint8", "uint256", "uint256"],
//       [affixNamingComponentId, partId, lootProtoEntityId, affixProtoEntity]
//     )
//   ) as Entity;
//   const affixNamingEntity = world.entityToIndex.get(affixNamingEntityId);
//   let naming;
//   if (affixNamingEntity === undefined) {
//     console.warn(`affix naming entity index not found for id ${affixNamingEntityId}`);
//     naming = "";
//   } else {
//     naming = getComponentValueStrict(AffixNaming, affixNamingEntity);
//   }
//
//   return {
//     naming,
//     partId: partId as AffixPartId,
//     protoEntity: affixProtoEntity,
//     affixPrototype: getAffixPrototype(components, affixProtoEntity),
//     value,
//     statmod,
//   };
// }
//
// function getAffixPrototype(
//   components: Pick<SetupResult["components"], "Name" | "AffixPrototype">,
//   entity: Entity
// ) {
//   const { Name, AffixPrototype } = components;
//   return {
//     ...getComponentValueStrict(AffixPrototype, entity),
//     name: getComponentValueStrict(Name, entity),
//   };
// }
