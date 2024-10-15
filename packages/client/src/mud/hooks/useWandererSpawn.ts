import { useCallback } from "react";
import { useMUD } from "../../MUDContext";
import { Hex } from "viem";

export const useWandererSpawn = (guiseProtoEntity: Hex) => {
  const { systemCalls } = useMUD();

  return useCallback(async () => {
    await systemCalls.wandererSpawn(guiseProtoEntity);
  }, [systemCalls, guiseProtoEntity]);
};
