import { useMemo } from "react";
import { useStashCustom } from "../../mud/stash";
import { getCombatLog } from "../../mud/utils/combat";
import { useWandererContext } from "../../contexts/WandererContext";
import { CombatRoundOutcome } from "./CombatRoundOutcome";
import CombatActions from "./CombatActions";
import { DotsLoader } from "../utils/DotsLoader/DotsLoader";

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
    <section className="p-4 flex flex-col items-center w-full">
      <div className="flex justify-center w-full">
        <div className="text-2xl text-dark-comment mr-2">
          {"// selected map"}
        </div>
        <span className="text-xl text-dark-comment"></span>
      </div>
      {enemyEntity ? (
        lastRound ? (
          <CombatRoundOutcome roundLog={lastRound} />
        ) : (
          <div>
            <DotsLoader text="Loading combat log" />
          </div>
        )
      ) : (
        <div>No enemy selected. Loading battle...</div>
      )}
      <CombatActions />
    </section>
  );
}
