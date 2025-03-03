import { useEntityQuery } from "@latticexyz/react";
import { Has, HasValue, Not, ProxyExpand, ProxyRead } from "@latticexyz/recs";
import { useMemo } from "react";
import { getLoot } from "../utils/getLoot";
import { useMUD } from "../../MUDContext";

export const useMaps = (prototypeName: string) => {
  const { components } = useMUD();
  const { MapTypeComponent, Name, FromTemplate } = components;

  const mapEntities = useEntityQuery([
    ProxyRead(FromTemplate, 1),
    ProxyExpand(FromTemplate, 1),
    Has(MapTypeComponent),
    HasValue(Name, { value: prototypeName }),
    ProxyRead(FromTemplate, 0),
    ProxyExpand(FromTemplate, 0),
    Not(MapTypeComponent),
  ]);

  return useMemo(() => {
    return mapEntities
      .map((mapEntity) => {
        return getLoot(components, mapEntity);
      })
      .sort((a, b) => a.ilvl - b.ilvl);
  }, [components, mapEntities]);
};
