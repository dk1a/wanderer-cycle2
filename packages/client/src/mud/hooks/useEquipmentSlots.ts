import {
  Entity,
  getComponentValueStrict,
  Has,
  HasValue,
} from "@latticexyz/recs";
import { useMemo } from "react";
import { useEntityQuery } from "../useEntityQuery";
import { getLoot } from "../utils/getLoot";
import {
  EquipmentAction,
  useChangeCycleEquipment,
} from "./useChangeCycleEquipment";
import { useMUD } from "../../MUDContext";

export type EquipmentSlot = ReturnType<typeof useEquipmentSlots>[number];

// TODO it may be better to restructure stuff so ownerEntity can't be undefined
export const useEquipmentSlots = (ownerEntity: Entity | undefined) => {
  const { components } = useMUD();
  const { OwnedBy, SlotAllowedTypes, SlotEquipment } = components;

  const changeCycleEquipment = useChangeCycleEquipment();
  // TODO it may be better to restructure stuff so ownerEntity can't be undefined

  const slotEntities = useEntityQuery(
    [HasValue(OwnedBy, { value: ownerEntity }), Has(SlotAllowedTypes)],
    true,
  );

  // TODO this is very hacky reactivity nonsense, refactor in v2
  const slotEntitiesWithEquipment = useEntityQuery(
    [HasValue(OwnedBy, { value: ownerEntity }), Has(SlotEquipment)],
    true,
  );

  return useMemo(() => {
    return slotEntities.map((slotEntity) => {
      const { Name, SlotAllowedTypes, SlotEquipment } = components;

      const name = getComponentValueStrict(Name, slotEntity);
      const equipmentProtoEntityS = getComponentValueStrict(
        SlotAllowedTypes,
        slotEntity,
      );

      const equippedEntity = (() => {
        if (!slotEntitiesWithEquipment.includes(slotEntity)) return;

        const equippedEntity = getComponentValueStrict(
          SlotEquipment,
          slotEntity,
        );
        if (!equippedEntity) {
          throw new Error(
            `No entity index for equipped entity id ${equippedEntity}`,
          );
        }
        return equippedEntity;
      })();

      const unequip = () => {
        if (equippedEntity === undefined)
          throw new Error("Slot has not equipment to unequip");
        changeCycleEquipment(
          EquipmentAction.UNEQUIP,
          slotEntity,
          equippedEntity,
        );
      };

      return {
        entity: slotEntity,
        name,
        equipmentProtoEntityS,
        equipped: equippedEntity
          ? getLoot(components, equippedEntity)
          : undefined,
        unequip,
      };
    });
  }, [
    components,
    slotEntities,
    slotEntitiesWithEquipment,
    changeCycleEquipment,
  ]);
};
