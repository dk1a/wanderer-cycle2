import {
  createContext,
  ReactNode,
  useCallback,
  useContext,
  useState,
} from "react";
import { Hex } from "viem";
import {
  CycleCombatRewardRequest,
  CombatLog,
  getCombatLog,
  // useActiveCombat,
  // useCycleCombatRewardRequests,
  // useOnCombatResultEffect,
} from "../mud/utils/combat";
import { useMUD } from "../MUDContext";
import { getRecordStrict, mudTables, useStashCustom } from "../mud/stash";
import { getLearnedSkillEntities } from "../mud/utils/skill";
import { getActiveCombat } from "../mud/utils/combat";

type WandererContextType = {
  selectedWandererEntity?: Hex;
  selectWandererEntity: (wanderer: Hex | undefined) => void;
  cycleEntity?: Hex;
  previousCycleEntity?: Hex;
  enemyEntity?: Hex;
  combatRewardRequests: CycleCombatRewardRequest[];
  combatLog?: CombatLog;
  // clearCombatResult: () => void;
  learnCycleSkill: (skillEntity: Hex) => Promise<void>;
  learnedSkillEntities: readonly Hex[];
  wandererMode: boolean;
  toggleWandererMode: () => void;
};

const WandererContext = createContext<WandererContextType | undefined>(
  undefined,
);

export const WandererProvider = (props: { children: ReactNode }) => {
  const currentValue = useContext(WandererContext);
  if (currentValue) throw new Error("WandererProvider can only be used once");

  const [selectedWandererEntity, selectWandererEntity] = useState<Hex>();

  const { systemCalls } = useMUD();

  // current cycle
  const activeCycle = useStashCustom((state) => {
    if (!selectedWandererEntity) {
      console.warn("No selected wanderer entity");
      return undefined;
    }

    return getRecordStrict({
      state,
      table: mudTables.root__ActiveCycle,
      key: { entity: selectedWandererEntity },
    });
  });
  const cycleEntity = activeCycle?.cycleEntity;

  // // previous cycle
  // const cyclePrevious = useMemo(() => {
  //   if (!selectedWandererEntity) {
  //     console.warn("No selected wanderer entity");
  //     return undefined;
  //   }
  //   return getComponentValueStrict(PreviousCycle, selectedWandererEntity);
  // }, [ActiveCycle, selectedWandererEntity]);
  // const previousCycleEntity = cyclePrevious?.toEntity as Entity | undefined;

  const enemyEntity = useStashCustom((state) => {
    if (!cycleEntity) return;
    return getActiveCombat(state, cycleEntity)?.retaliatorEntity;
  });

  const combatLog = useStashCustom((state) => {
    if (!cycleEntity || !enemyEntity) return undefined;
    return getCombatLog(state, cycleEntity, enemyEntity);
  });

  const learnCycleSkill = useCallback(
    async (skillEntity: Hex) => {
      if (cycleEntity === undefined) throw new Error("No cycle entity");
      await systemCalls.learnCycleSkill(cycleEntity, skillEntity);
    },
    [systemCalls, cycleEntity],
  );
  const learnedSkillEntities = useStashCustom((state) => {
    if (!cycleEntity) return [];
    return getLearnedSkillEntities(state, cycleEntity);
  });

  const [wandererMode, setWandererMode] = useState(false);
  const toggleWandererMode = useCallback(
    () => setWandererMode((value) => !value),
    [],
  );

  const value = {
    selectedWandererEntity,
    selectWandererEntity,
    cycleEntity,
    learnCycleSkill,
    learnedSkillEntities,
    wandererMode,
    toggleWandererMode,
    // previousCycleEntity,
    enemyEntity,
    combatLog,
    // combatRewardRequests,
    // clearCombatResult,
  };
  return (
    <WandererContext.Provider value={value}>
      {props.children}
    </WandererContext.Provider>
  );
};

export const useWandererContext = () => {
  const value = useContext(WandererContext);
  if (!value) throw new Error("Must be used within a WandererProvider");
  return value;
};
