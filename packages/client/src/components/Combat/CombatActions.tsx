import React, { useCallback, useMemo, useState } from "react";
import { useWandererContext } from "../../contexts/WandererContext";
import {
  CombatAction,
  CombatActionType,
  attackAction,
} from "../../mud/utils/combat";
import { getSkill, SkillType } from "../../mud/utils/skill";
import { useMUD } from "../../MUDContext";
import { useStashCustom } from "../../mud/stash";
import { UseSkillButton } from "../UseSkillButton";
import { Button } from "../utils/Button/Button";
import Select from "react-select";

export default function CombatActions() {
  const { systemCalls } = useMUD();
  const { cycleEntity, learnedSkillEntities } = useWandererContext();
  const [isBusy, setIsBusy] = useState(false);
  const [selectedSkill, selectSkill] = useState<{
    value: string;
    label: string;
  } | null>(null);

  const skills = useStashCustom((state) => {
    return learnedSkillEntities.map((entity) => getSkill(state, entity));
  });

  const combatSkills = useMemo(
    () => skills.filter(({ skillType }) => skillType === SkillType.COMBAT),
    [skills],
  );

  const skillOptions = useMemo(
    () =>
      combatSkills.map(({ name, entity }) => ({ value: entity, label: name })),
    [combatSkills],
  );

  const handleRound = async (actions: CombatAction[]) => {
    if (!cycleEntity) {
      console.warn("No cycleEntity selected");
      return;
    }

    setIsBusy(true);
    try {
      await systemCalls.processCycleCombatRound(cycleEntity, actions);
    } catch (err) {
      console.error("Combat round failed", err);
    } finally {
      setIsBusy(false);
    }
  };

  const onAttack = useCallback(async () => {
    await handleRound([attackAction]);
  }, [cycleEntity]);

  const onSkill = useCallback(async () => {
    if (!selectedSkill) {
      console.warn("No skill selected");
      return;
    }

    const fullSkill = combatSkills.find(
      (s) => s.entity === selectedSkill.value,
    );
    if (!fullSkill) {
      console.warn("Selected skill not found in combatSkills");
      return;
    }

    const skillAction: CombatAction = {
      actionType: CombatActionType.SKILL,
      actionEntity: fullSkill.entity,
    };

    await handleRound([skillAction]);
  }, [selectedSkill, combatSkills, cycleEntity]);

  return (
    <div className="w-1/2 flex flex-col items-center mt-4">
      <div className="flex flex-col items-center justify-around w-full">
        <div className="flex items-center justify-center w-full gap-x-8">
          <Select
            classNamePrefix={"custom-select"}
            placeholder={"Select a skill"}
            options={skillOptions}
            onChange={selectSkill}
            value={selectedSkill}
          />
          {selectedSkill && (
            <UseSkillButton
              entity={selectedSkill?.value}
              onSkill={onSkill}
              style={{ width: "9rem" }}
            />
          )}
        </div>
      </div>
      <div className="mt-4">
        <Button style={{ width: "9rem" }} onClick={onAttack} disabled={isBusy}>
          Attack
        </Button>
      </div>
    </div>
  );
}
