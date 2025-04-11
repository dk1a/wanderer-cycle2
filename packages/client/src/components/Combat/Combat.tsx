import { useWandererContext } from "../../contexts/WandererContext";
import { CombatRoundOutcome } from "./CombatRoundOutcome";
// import CombatActions from "./CombatActions";

export function Combat() {
  const { combatLog, enemyEntity } = useWandererContext();

  const lastRound =
    combatLog && combatLog.rounds && combatLog.rounds.length > 0
      ? combatLog.rounds[combatLog.rounds.length - 1]
      : undefined;

  return (
    <section className="p-2 flex flex-col items-center w-full">
      <div className="flex justify-center w-1/2">
        <div className="text-2xl text-dark-comment mr-2">
          {"//selected map"}
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
      {/*<CombatActions />*/}
    </section>
  );
}
