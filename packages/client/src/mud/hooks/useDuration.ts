import { useComponentValue } from "@latticexyz/react";
import { useMemo } from "react";
import { parseScopedDuration } from "../utils/scopedDuration";
import type { Entity } from "@latticexyz/recs";
import { useMUD } from "../../MUDContext";

export const useDuration = (
  targetEntity: Entity | undefined,
  applicationEntity: Entity | undefined,
) => {
  const {
    components: { GenericDuration },
  } = useMUD();

  const key = useMemo(() => {
    if (!targetEntity || !applicationEntity) return;
    return [targetEntity, applicationEntity];
  }, [targetEntity, applicationEntity]);

  const durationRecord = useComponentValue(GenericDuration, key);

  return useMemo(() => {
    if (!durationRecord) return;
    return {
      timeId: durationRecord.timeId,
      ...parseScopedDuration(
        durationRecord.timeId,
        durationRecord.timeValue.toString(),
      ),
    };
  }, [durationRecord]);
};
