import { useComponentValue } from "@latticexyz/react";
import { useMemo } from "react";
import type { Entity } from "@latticexyz/recs";
import { useMUD } from "../../MUDContext";

export const useBossesDefeated = (entity: Entity | undefined) => {
  const {
    network: { components },
  } = useMUD();

  const bossesDefeatedRecord = useComponentValue(
    components.BossesDefeated,
    entity,
  );

  return useMemo(() => {
    return bossesDefeatedRecord?.value ?? [];
  }, [bossesDefeatedRecord]);
};
