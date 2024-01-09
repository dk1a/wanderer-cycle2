import { EntityIndex } from "@latticexyz/recs";
import { useLoot } from "../../mud/hooks/useLoot";
import cls from "./EffectNameItem.module.scss";
import {classNames} from "@/shared/lib/classNames/classNames";

interface EffectProps{
  className?: string;
  entity: EntityIndex;
}

export default function EffectNameItem(props : EffectProps ) {
  const loot = useLoot(props.entity);

  return (
    <>
      <span className={cls.Item} title={loot.name}>
        {loot.name}
      </span>
    </>
  );
}
