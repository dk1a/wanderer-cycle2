import { Entity } from "@latticexyz/recs";
import { useMemo } from "react";
import { getLoot } from "../utils/getLoot";
import { useMUD } from "../../MUDContext";

export const useLoot = (entity: Entity) => {
  const { components } = useMUD();

  return useMemo(() => {
    return getLoot(components, entity);
  }, [components, entity]);
};
