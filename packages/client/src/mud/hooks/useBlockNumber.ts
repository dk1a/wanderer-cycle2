import { useEffect, useState } from "react";
import { useMUD } from "../../MUDContext";

export function useBlockNumber() {
  const {
    network: { publicClient },
  } = useMUD();
  const [blockNumber, setBlockNumber] = useState<number | undefined>();

  useEffect(() => {
    if (!publicClient || typeof publicClient.getBlockNumber !== "function")
      return;

    let mounted = true;

    async function updateBlockNumber() {
      try {
        const bn = await publicClient.getBlockNumber();
        if (mounted) {
          setBlockNumber(Number(bn));
        }
      } catch (error) {
        console.error("Error fetching block number:", error);
      }
    }

    updateBlockNumber();

    const interval = setInterval(updateBlockNumber, 10_000);

    return () => {
      mounted = false;
      clearInterval(interval);
    };
  }, [publicClient]);

  return blockNumber;
}
