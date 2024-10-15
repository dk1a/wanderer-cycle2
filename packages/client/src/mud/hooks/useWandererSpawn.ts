import { useCallback } from "react";
import { useMUD } from "../../MUDContext";
import { Hex } from "viem";

export const useWandererSpawn = () => {
  const { systemCalls } = useMUD();

  return useCallback(
    async (guiseProtoEntity: Hex) => {
      await systemCalls.wandererSpawn(guiseProtoEntity);
    },
    [systemCalls],
  );
};
