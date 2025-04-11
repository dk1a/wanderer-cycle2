import { CSSProperties } from "react";
import { useStashCustom } from "../mud/stash";
import { getSkill } from "../mud/utils/skill";
import { Hex } from "viem";
import { getManaCurrent } from "../mud/utils/currents";
import { Button } from "./utils/Button/Button";

type UseSkillButtonData = {
  entity: Hex | undefined;
  onSkill: () => Promise<void>;
  style?: CSSProperties;
};
export function UseSkillButton({ entity, onSkill, style }: UseSkillButtonData) {
  const skill = useStashCustom((state) => getSkill(state, entity));
  const manaCurrent = useStashCustom((state) => getManaCurrent(state, entity));

  return (
    <div className="flex">
      <Button
        style={style}
        onClick={onSkill}
        disabled={
          skill === undefined ||
          manaCurrent === undefined ||
          manaCurrent <= skill.cost ||
          (skill.duration !== undefined && skill.duration.timeValue > 0)
        }
      >
        use skill
      </Button>
      {skill.duration !== undefined && skill.duration.timeValue > 0 && (
        <div className="ml-2">
          <div className="text-dark-300">
            {"("}
            <span className="text-dark-number">
              {skill.duration.timeValue}{" "}
            </span>
            {/*<span className="text-dark-string">{skill.duration.timeScopeName}</span>*/}
            {")"}
          </div>
        </div>
      )}
    </div>
  );
}
