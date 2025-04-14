import { useStashCustom } from "../../mud/stash";
import { useWandererContext } from "../../contexts/WandererContext";
import { CombatRoundOutcome } from "./CombatRoundOutcome";
import CombatActions from "./CombatActions";
import { getCombatLog } from "../../mud/utils/combat";
import { useMemo } from "react";

export function Combat() {
  const { cycleEntity, enemyEntity } = useWandererContext();

  const combatLog = useStashCustom((state) => {
    if (!cycleEntity || !enemyEntity) return undefined;
    return getCombatLog(state, cycleEntity, enemyEntity);
  });

  const lastRound = useMemo(() => {
    return combatLog && combatLog.rounds && combatLog.rounds.length > 0
      ? combatLog.rounds[combatLog.rounds.length - 1]
      : undefined;
  }, [combatLog]);

  return (
    <section className="p-2 flex flex-col items-center w-full">
      <div className="flex justify-center w-1/2">
        <div className="text-2xl text-dark-comment mr-2">
          {"// selected map"}
        </div>
        <span className="text-xl text-dark-comment"></span>
      </div>
      {enemyEntity ? (
        lastRound ? (
          <CombatRoundOutcome roundLog={lastRound} />
        ) : (
          <div>Loading combat log...</div>
        )
      ) : (
        <div>No enemy selected. Loading battle...</div>
      )}
      <CombatActions />
    </section>
  );
}
