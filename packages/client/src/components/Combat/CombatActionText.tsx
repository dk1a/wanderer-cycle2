import React from "react";
import { CombatActionLog, CombatActionType } from "../../mud/utils/combat";
import { getSkill } from "../../mud/utils/skill";
import { useStashCustom } from "../../mud/stash";

export function CombatActionText({
  actionLog,
}: {
  actionLog: CombatActionLog;
}) {
  const { action, defenderLifeDiff } = actionLog;

  const skillName = useStashCustom((state) => {
    if (action.actionType !== CombatActionType.SKILL) return "";
    if (!action.actionEntity) return "";
    return getSkill(state, action.actionEntity).name;
  });

  let actionText = "";
  if (action.actionType === CombatActionType.ATTACK) {
    actionText = "Attack";
  } else if (action.actionType === CombatActionType.SKILL) {
    actionText = `Used Skill ${skillName}`;
  } else {
    console.warn(`Unknown actionType ${action.actionType}`);
  }

  return (
    <div className="flex items-center space-x-2">
      <span className="text-dark-string text-[19px]">{actionText}</span>
      <span className="text-dark-number">Damage: {defenderLifeDiff}</span>
    </div>
  );
}
