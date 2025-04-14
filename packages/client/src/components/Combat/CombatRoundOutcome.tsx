import { CombatActionText } from "./CombatActionText";
import { CombatRoundLog } from "../../mud/utils/combat";

export function CombatRoundOutcome({ roundLog }: { roundLog: CombatRoundLog }) {
  return (
    <div className="flex flex-col items-center">
      <div className="mb-4">
        <span className="text-dark-key text-xl">Round: </span>
        <span className="text-dark-number text-xl">
          {roundLog.roundIndex + 1}
        </span>
      </div>

      <div className="w-full flex justify-around">
        <div>
          <h3 className="text-dark-title">Your Actions</h3>
          {roundLog.initiatorActions.map((actionLog) => (
            <CombatActionText
              key={`initiator-${actionLog.actionIndex}`}
              actionLog={actionLog}
            />
          ))}
        </div>
        <div>
          <h3 className="text-dark-title">Enemy Actions</h3>
          {roundLog.retaliatorActions.map((actionLog) => (
            <CombatActionText
              key={`retaliator-${actionLog.actionIndex}`}
              actionLog={actionLog}
            />
          ))}
        </div>
      </div>
    </div>
  );
}
