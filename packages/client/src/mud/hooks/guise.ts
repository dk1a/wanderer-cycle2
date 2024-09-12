import { useComponentValue } from "@latticexyz/react";
import { Has, Entity } from "@latticexyz/recs";
import { useMemo } from "react";
import { useEntityQuery } from "@latticexyz/react";
import { getGuise } from "../utils/guise";
import { useMUD } from "../../MUDContext";

export const useGuise = (entity: Entity | undefined) => {
  const mud = useMUD();

  return useMemo(() => {
    if (entity === undefined) return;
    return getGuise(mud, entity);
  }, [mud, entity]);
};

export const useGuises = () => {
  const mud = useMUD();
  const {
    components: { GuisePrototype },
  } = mud;

  const guiseEntities = useEntityQuery([Has(GuisePrototype)]);
  return useMemo(() => {
    return guiseEntities.map((guiseEntity) => getGuise(mud, guiseEntity));
  }, [mud, guiseEntities]);
};

export const useActiveGuise = (targetEntity: Entity | undefined) => {
  const mud = useMUD();
  const {
    world,
    components: { ActiveGuise },
  } = mud;

  const activeGuise = useComponentValue(ActiveGuise, targetEntity);
  const guiseEntity = useMemo(() => {
    const guiseEntityId = activeGuise?.value;
    if (!guiseEntityId) return;
    return world.entityToIndex.get(guiseEntityId);
  }, [world, activeGuise]);

  return useGuise(guiseEntity);
};
