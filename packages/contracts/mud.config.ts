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
    Experience: {
      ...entityKey,
      schema: arrayPStat,
    },
    ActiveGuise: entityRelation,
    GuisePrototype: {
      ...entityKey,
      schema: arrayPStat,
    },
    LearnedSkills: {
      ...entityKey,
      schema: EntityIdSet,
    },
    SkillTemplate: {
      ...entityKey,
      schema: {
        // level required to learn it
        requiredLevel: "uint8",
        // when/how it can be used
        skillType: "SkillType",
        // flag to also trigger an attack afterwards (base attack damage is not based on the skill)
        withAttack: "bool",
        // flag to also trigger a spell afterwards (`SpellDamage` is used for base damage)
        withSpell: "bool",
        // mana cost to be subtracted on use
        cost: "uint32",
        // who it can be used on
        targetType: "TargetType",
      },
    },
    // initiatorEntity => retaliatorEntity
    // An entity can initiate only 1 combat at a time
    ActiveCombat: entityRelation,
    ActiveCycle: {
      ...entityKey,
      schema: "uint32",
    },
    CycleTurns: {
      ...entityKey,
      schema: "uint32",
    },
    CycleTurnsLastClaimed: {
      ...entityKey,
      schema: "uint48",
    },
    RNGPrecommit: {
      ...entityKey,
      schema: "uint256",
    },
    // requestId => ownerEntity
    RNGRequestOwner: entityRelation,
  },
  enums: {
    SkillType: ["COMBAT", "NONCOMBAT", "PASSIVE"],
    TargetType: ["SELF", "ENEMY", "ALLY", "SELF_OR_ALLY"],
  },
  modules: [
    ...keysWithValue(["Experience", "LearnedSkills"]),
    {
      name: "UniqueEntityModule",
      root: true,
      args: [],
    },
  ],
});
