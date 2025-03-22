import { useManaCurrent } from "../mud/hooks/currents";
import { useWandererContext } from "../contexts/WandererContext";
import { CSSProperties } from "react";
import { Entity } from "@latticexyz/recs";
import { useSkill } from "../mud/hooks/skill";
import { Button } from "./utils/Button/Button";

// import { useDuration } from "../mud/hooks/useDuration";

type UseSkillButtonData = {
  entity: Entity | undefined;
  onSkill?: () => Promise<void>;
  style?: CSSProperties;
};
export function UseSkillButton({ entity, onSkill, style }: UseSkillButtonData) {
  const skill = useSkill(entity);
  const { cycleEntity } = useWandererContext();
  const manaCurrent = useManaCurrent(cycleEntity);
  // const skillEntity = useMemo(() => skill?.entity, [skill]);
  // const duration = useDuration(cycleEntity, skillEntity);

  return (
    <div className="flex">
      <Button
        style={style}
        onClick={onSkill}
        disabled={
          skill === undefined ||
          manaCurrent === undefined ||
          manaCurrent <= skill.cost
          // || (duration !== undefined && duration.timeValue > 0)
        }
      >
        use skill
      </Button>
      {/*{duration !== undefined && duration.timeValue > 0 && (*/}
      {/*  <div className="ml-2">*/}
      {/*    <div className="text-dark-300">*/}
      {/*      {"("}*/}
      {/*      /!*<span className="text-dark-number">{duration.timeValue} </span>*!/*/}
      {/*      /!*<span className="text-dark-string">{duration.timeScopeName}</span>*!/*/}
      {/*      {")"}*/}
      {/*    </div>*/}
      {/*  </div>*/}
      {/*)}*/}
    </div>
  );
}
