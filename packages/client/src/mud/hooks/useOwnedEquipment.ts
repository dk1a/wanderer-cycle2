import { Has, HasValue, Not, ProxyExpand } from "@latticexyz/recs";
import { useMemo } from "react";
import { useWandererContext } from "../../contexts/WandererContext";
import { useEntityQuery } from "../useEntityQuery";
import { getLoot } from "../utils/getLoot";
import { useMUD } from "../../MUDContext";

export const useOwnedEquipment = () => {
  const { components } = useMUD();
  const { cycleEntity } = useWandererContext();
  const { OwnedBy, SlotAllowedTypes, FromTemplate } = components;

  const equipmentEntities = useEntityQuery(
    [
      ProxyExpand(FromTemplate, 1),
      Has(SlotAllowedTypes),
      ProxyExpand(FromTemplate, 0),
      Not(SlotAllowedTypes),
      HasValue(OwnedBy, { value: cycleEntity ? cycleEntity : undefined }),
    ],
    true,
  );

  return useMemo(() => {
    return equipmentEntities.map((entity) => {
      return getLoot(components, entity);
    });
  }, [components, equipmentEntities]);
};
