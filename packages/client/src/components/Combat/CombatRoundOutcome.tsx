import { CombatActionText } from "./CombatActionText";
import { CombatRoundLog } from "../../mud/utils/combat";
import { Table } from "../utils/Table/Table";

export function CombatRoundOutcome({ roundLog }: { roundLog: CombatRoundLog }) {
  const maxLength = Math.max(
    roundLog.initiatorActions.length,
    roundLog.retaliatorActions.length,
  );

  const data = Array.from({ length: maxLength }).map((_, index) => ({
    initiator: roundLog.initiatorActions[index] ? (
      <CombatActionText actionLog={roundLog.initiatorActions[index]} />
    ) : null,
    retaliator: roundLog.retaliatorActions[index] ? (
      <CombatActionText actionLog={roundLog.retaliatorActions[index]} />
    ) : null,
  }));

  const columns = [
    {
      key: "initiator",
      label: "Your Actions",
    },
    {
      key: "retaliator",
      label: "Enemy Actions",
    },
  ];

  return (
    <div className="w-full flex flex-col items-center">
      <div className="w-full flex justify-start pr-10 mb-2">
        <span className="text-dark-key text-xl mr-1">Round:</span>
        <span className="text-dark-number text-xl">
          {roundLog.roundIndex + 1}
        </span>
      </div>

      <div className="w-full">
        <Table columns={columns} data={data} onSort={() => {}} />
      </div>
    </div>
  );
}
