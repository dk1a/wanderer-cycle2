import { useComponentValue, useEntityQuery } from "@latticexyz/react";
import { Entity, Has } from "@latticexyz/recs";
import { useCallback, useMemo } from "react";
import { getSkill } from "../utils/skill";
import { useMUD } from "../../MUDContext";

export const useSkill = (entity: Entity | undefined) => {
  const { components } = useMUD();

  return useMemo(() => {
    if (entity === undefined) return undefined;
    return getSkill(components, entity);
  }, [components, entity]);
};

export const useSkillStrict = (entity: Entity) => {
  const { components } = useMUD();

  return useMemo(() => {
    return getSkill(components, entity);
  }, [components, entity]);
};

export const useSkills = (entities: Entity[]) => {
  const { components } = useMUD();

  return useMemo(() => {
    return entities.map((entity) => {
      return getSkill(components, entity);
    });
  }, [components, entities]);
};

export const useAllSkillEntities = () => {
  const {
    components: { SkillPrototype },
  } = useMUD();

  return useEntityQuery([Has(SkillPrototype)]);
};

export const useLearnedSkillEntities = (targetEntity: Entity | undefined) => {
  const {
    world,
    components: { LearnedSkills },
  } = useMUD();

  const learnedSkills = useComponentValue(LearnedSkills, targetEntity);
  return useMemo(() => {
    const entityIds = learnedSkills?.value ?? [];
    return entityIds.map((entityId) => {
      const entity = world.entityToIndex.get(entityId);
      if (entity === undefined)
        throw new Error(`No index for entity id ${entityId}`);
      return entity;
    });
  }, [world, learnedSkills]);
};

export const useLearnCycleSkill = (wandererEntity: Entity | undefined) => {
  const { world, systems } = useMUD();

  return useCallback(
    async (skillEntity: Entity) => {
      if (wandererEntity === undefined) throw new Error("No wanderer selected");
      const tx = await systems["system.LearnCycleSkill"].executeTyped(
        world.entities[wandererEntity],
        world.entities[skillEntity],
      );
      await tx.wait();
    },
    [world, systems, wandererEntity],
  );
};

export const usePermSkill = (wandererEntity: Entity | undefined) => {
  const { world, systems } = useMUD();

  return useCallback(
    async (skillEntity: Entity) => {
      if (wandererEntity === undefined) throw new Error("No wanderer selected");
      const tx = await systems["system.PermSkill"].executeTyped(
        world.entities[wandererEntity],
        world.entities[skillEntity],
      );
      await tx.wait();
    },
    [world, systems, wandererEntity],
  );
};

export const useExecuteNoncombatSkill = () => {
  const { world, systems } = useMUD();

  return useCallback(
    async (cycleEntity: Entity, skillEntity: Entity) => {
      const tx = await systems["system.NoncombatSkill"].executeTyped(
        world.entities[cycleEntity],
        world.entities[skillEntity],
      );
      await tx.wait();
    },
    [world, systems],
  );
};
