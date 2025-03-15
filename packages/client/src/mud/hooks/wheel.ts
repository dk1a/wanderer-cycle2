import { Entity, getComponentValueStrict, Has } from "@latticexyz/recs";
import { useComponentValue } from "@latticexyz/react";
import { useMemo } from "react";
import { SetupResult } from "../setup";
import { useEntityQuery } from "../useEntityQuery";
import { useMUD } from "../../MUDContext";

export type WheelData = ReturnType<typeof getWheel>;
export type WheelCompletedData = ReturnType<typeof getWheel> & {
  completed: number;
};

export const useWheels = () => {
  const mud = useMUD();
  const {
    components: { Wheel },
  } = mud;

  const wheelEntities = useEntityQuery([Has(Wheel)], true);
  return useMemo(() => {
    return wheelEntities.map((wheelEntity) => getWheel(mud, wheelEntity));
  }, [mud, wheelEntities]);
};

export const useWheel = (entity: Entity | undefined) => {
  const mud = useMUD();

  return useMemo(() => {
    if (entity === undefined) return;
    return getWheel(mud, entity);
  }, [mud, entity]);
};

export const useActiveWheel = (entity: Entity | undefined) => {
  const {
    components: { ActiveWheel },
  } = useMUD();

  const activeWheel = useComponentValue(ActiveWheel, entity);

  return useMemo(() => {
    if (activeWheel === undefined) return;
    return activeWheel;
  }, [activeWheel]);
};

export const useWheelsCompleted = (
  wandererEntity: Entity | undefined,
): WheelCompletedData[] => {
  const mud = useMUD();
  const { components } = mud;
  const { Wheel, WheelsCompleted } = components;

  // TODO same issues as useAppliedEffects
  const wheelEntities = useEntityQuery([Has(Wheel)], true);
  const wheelsCompletedEntities = useEntityQuery([Has(WheelsCompleted)], true);

  return useMemo(() => {
    if (wandererEntity === undefined) return [];

    return wheelEntities.map((wheelEntity) => {
      // const bytes = defaultAbiCoder.encode(
      //   ["bytes32", "bytes32"],
      //   [wandererEntity, wheelEntity],
      // );
      // const compositeEntityId = keccak256(bytes) as EntityID;
      // const compositeEntity = world.entityToIndex.get(compositeEntityId);
      //
      // let completed = 0;
      // if (
      //   compositeEntity !== undefined &&
      //   wheelsCompletedEntities.includes(compositeEntity)
      // ) {
      //   completed = getComponentValueStrict(
      //     WheelsCompleted,
      //     compositeEntity,
      //   ).value;
      // }

      return {
        ...getWheel(mud, wheelEntity),
        // completed,
      };
    });
  }, [
    mud,
    WheelsCompleted,
    wheelEntities,
    wheelsCompletedEntities,
    wandererEntity,
  ]);
};

const getWheel = (
  { components: { Wheel, Name } }: SetupResult,
  entity: Entity,
) => {
  const wheel = getComponentValueStrict(Wheel, entity);
  const name = getComponentValueStrict(Name, entity);

  return {
    wheel,
    name,
    entity,
    wheelEntityId: entity,
    totalIdentityRequired: wheel.totalIdentityRequired,
    charges: wheel.charges,
    isIsolated: wheel.isIsolated,
  };
};
