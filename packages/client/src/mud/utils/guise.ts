import { getComponentValueStrict } from "@latticexyz/recs";
import { SetupResult } from "../setup";
import { Entity } from "@latticexyz/recs/src/types";

export type GuiseData = ReturnType<typeof getGuise>;

export const getGuise = (components: SetupResult, entity: Entity) => {
  const guisePrototype = getComponentValueStrict(
    components.GuisePrototype,
    entity,
  );
  const skillEntities = getComponentValueStrict(components.GuiseSkills, entity);
  const name = getComponentValueStrict(components.Name, entity);

  const affixPart = Array.isArray(guisePrototype.affixPart)
    ? guisePrototype.affixPart
    : [];
  const [arcana = 0, dexterity = 0, strength = 0] = affixPart;

  return {
    entity,
    name: name?.value ?? "",

    levelMul: {
      arcana,
      dexterity,
      strength,
    },

    skillEntities,
  };
};
