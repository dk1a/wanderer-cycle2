import React, { useCallback, useMemo, useState } from "react";
import Select from "react-select";
import { useWandererContext } from "../../contexts/WandererContext";
import { useExecuteCycleCombatRound } from "../../mud/hooks/combat";
import { useSkills } from "../../mud/hooks/skill";
import {
  CombatAction,
  CombatActionType,
  attackAction,
} from "../../mud/utils/combat";
import { SkillType } from "../../mud/utils/skill";
import CustomButton from "../UI/Button/CustomButton";
import "../UI/customSelect.scss";
import { UseSkillButton } from "../UseSkillButton";

export default function CombatActions() {
  const { cycleEntity, learnedSkillEntities } = useWandererContext();
  const [isBusy, setIsBusy] = useState(false);

  const executeCycleCombatRound = useExecuteCycleCombatRound();
  const onAttack = useCallback(async () => {
    if (!cycleEntity) throw new Error("Must select cycle entity");
    setIsBusy(true);
    await executeCycleCombatRound(cycleEntity, [attackAction]);
    setIsBusy(false);
  }, [cycleEntity, executeCycleCombatRound]);

  const skills = useSkills(learnedSkillEntities);
  const combatSkills = useMemo(
    () => skills.filter(({ skillType }) => skillType === SkillType.COMBAT),
    [skills],
  );
  const skillOptions = useMemo(
    () =>
      combatSkills.map(({ name, entity }) => ({ value: entity, label: name })),
    [combatSkills],
  );
  const [selectedSkill, selectSkill] = useState<
    (typeof skillOptions)[number] | null
  >(null);

  const onSkill = useCallback(async () => {
    if (!cycleEntity) throw new Error("Must select cycle entity");
    if (!selectedSkill) throw new Error("No skill selected");
    setIsBusy(true);
    const skillEntityId = entities[selectedSkill.value];
    const skillAction: CombatAction = {
      actionType: CombatActionType.SKILL,
      actionEntity: skillEntityId,
    };
    await executeCycleCombatRound(cycleEntity, [skillAction]);
    setIsBusy(false);
  }, [cycleEntity, executeCycleCombatRound, selectedSkill]);

  return (
    <div className="w-1/2 flex flex-col items-center mt-4">
      <div className="flex flex-col items-center justify-around w-full">
        <div className="flex items-center justify-center w-full gap-x-8">
          <Select
            classNamePrefix={"custom-select"}
            placeholder={"Select a skill"}
            value={selectedSkill}
            options={skillOptions}
            onChange={selectSkill}
          />
          <UseSkillButton
            entity={selectedSkill?.value}
            onSkill={onSkill}
            style={{ width: "9rem" }}
          />
        </div>
      </div>
      <div className="mt-4">
        <CustomButton
          style={{ width: "9rem" }}
          onClick={onAttack}
          disabled={isBusy}
        >
          Attack
        </CustomButton>
      </div>
    </div>
  );
}
