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
    DurationScope: {
      keySchema: {
        targetEntity: EntityId,
        baseEntity: EntityId,
      },
      schema: "bytes32",
    },
    DurationValue: {
      keySchema: {
        targetEntity: EntityId,
        baseEntity: EntityId,
      },
      schema: "uint48",
    },
    DurationOnEnd: {
      ...entityKey,
      schema: systemCallbackSchema,
    },

    EffectTemplate: {
      ...entityKey,
      schema: {
        entities: EntityIdArray,
        values: "uint32[]",
      },
    },
    EffectRemovability: {
      ...entityKey,
      schema: "EffectRemovabilityId",
    },
    EffectDuration: {
      ...entityKey,
      schema: scopedDurationSchema,
    },
    EffectApplied: {
      keySchema: {
        targetEntity: EntityId,
        sourceEntity: EntityId,
      },
      schema: {
        entities: EntityIdArray,
        values: "uint32[]",
      },
    },
    LearnedSkills: {
      ...entityKey,
      schema: EntityIdSet,
    },
    // most skill entities also have EffectTemplate for the effect triggered by skill use
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
  },
  enums: {
    EffectRemovabilityId: ["BUFF", "DEBUFF", "PERSISTENT"],
    SkillType: ["COMBAT", "NONCOMBAT", "PASSIVE"],
    TargetType: ["SELF", "ENEMY", "ALLY", "SELF_OR_ALLY"],
  },
  modules: [
    {
      name: "KeysInTableModule",
      root: true,
      args: [resolveTableId("Experience")],
    },
  ],
});
