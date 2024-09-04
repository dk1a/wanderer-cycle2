import { EntityIndex } from "@latticexyz/recs";
import CustomButton from "../UI/Button/CustomButton";
import { useWandererContext } from "../../contexts/WandererContext";

export default function Wanderer({
  wandererEntity,
}: {
  wandererEntity: EntityIndex;
}) {
  const { selectedWandererEntity, selectWandererEntity } = useWandererContext();

  return (
    <div className="">
      <div className="">
        {wandererEntity === selectedWandererEntity && (
          <CustomButton disabled={true}>
            <span className="">Selected</span>
          </CustomButton>
        )}
        {wandererEntity !== selectedWandererEntity && (
          <CustomButton
            style={{ width: "6rem" }}
            onClick={() => selectWandererEntity(wandererEntity)}
          >
            Select
          </CustomButton>
        )}
      </div>
    </div>
  );
}
