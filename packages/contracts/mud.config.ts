import { mudConfig, resolveTableId } from "@latticexyz/world/register";

// TODO user-defined type
const EntityId = "bytes32" as const;
const EntityIdArray = "bytes32[]" as const;
// TODO set
const EntityIdSet = "bytes32[]" as const;

const entityKey = {
  keySchema: {
    entity: EntityId,
  },
} as const;

const entityRelation = {
  ...entityKey,
  schema: EntityId,
} as const;

const systemCallbackSchema = {
  namespace: "bytes16",
  file: "bytes16",
  funcSelectorAndArgs: "bytes",
} as const;

const scopedDurationSchema = {
  scope: "bytes32",
  value: "uint48",
} as const;

const enumPStat = ["STRENGTH", "ARCANA", "DEXTERITY"];
const arrayPStat = `uint32[${enumPStat.length}]` as const;

const enumEleStat = ["NONE", "PHYSICAL", "FIRE", "COLD", "POISON"];
const arrayEleStat = `uint32[${enumEleStat.length}]` as const;

const keysWithValue = (tableNames: string[]) =>
  tableNames.map((tableName) => ({
    name: "KeysWithValueModule",
    root: true,
    args: [resolveTableId(tableName)],
  }));

export default mudConfig({
  tables: {
    Counter: {
      keySchema: {},
      schema: "uint32",
    },
    FromPrototype: entityRelation,
    AffixAvailable: {
      keySchema: {
        affixPart: "AffixPartId",
        targetEntity: EntityId,
        ilvl: "uint32",
      },
      schema: "uint256[]",
    },
    AffixNaming: {
      keySchema: {
        affixPart: "AffixPartId",
        targetEntity: EntityId,
        protoEntity: EntityId,
      },
      schema: "string",
    },
    AffixPrototype: {
      ...entityKey,
      schema: {
        statmodProtoEntity: EntityId,
        tier: "uint32",
        requiredLevel: "uint32",
        min: "uint32",
        max: "uint32",
      },
    },
    AffixProtoIndex: {
      keySchema: {
        nameHash: "bytes32",
        tier: "uint32",
      },
      schema: EntityId,
    },
    AffixProtoGroup: {
      keySchema: {
        nameHash: "bytes32",
      },
      schema: EntityId,
    },
    Affix: {
      ...entityKey,
      schema: {
        partId: "AffixPartId",
        protoEntity: EntityId,
        value: "uint32",
      },
    },
    Experience: {
      ...entityKey,
      schema: arrayPStat,
    },
    ActiveGuise: entityRelation,
    GuisePrototype: {
      ...entityKey,
      schema: arrayPStat,
    },
  },
  enums: {
    AffixPartId: ["IMPLICIT", "PREFIX", "SUFFIX"],
  },
  modules: [
    {
      name: "KeysInTableModule",
      root: true,
      args: [resolveTableId("Experience")],
    },
    {
      name: "UniqueEntityModule",
      root: true,
      args: [resolveTableId("Affix")],
    },
  ],
});
