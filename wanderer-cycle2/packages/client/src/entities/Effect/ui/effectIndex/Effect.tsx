import React, { useCallback } from "react";
// import { useWandererContext } from "@/contexts/WandererContext";
import {EffectNameItem, EffectNameSkill, EffectStatmod} from "@/entities/Effect";
// import { AppliedEffect, EffectSource } from "../../mud/utils/getEffect";
import cls from "./Effect.module.scss";
import {classNames} from "@/shared/lib/classNames/classNames";

interface EffectProps{
  className?: string;
}

export default function Effect({ entity, protoEntity, removability, statmods, effectSource }: AppliedEffect) {
  const { cycleEntity } = useWandererContext();

  const duration = useDuration(cycleEntity, entity);

  const removeEffect = useCallback(() => {
    console.log("TODO add removeEffect callback");
  }, []);

  const isItem = effectSource === EffectSource.NFT || effectSource === EffectSource.OWNABLE;

  return (
    <div className={cls.Effect}>
      <div className={cls.content}>
        {protoEntity && isItem && <EffectNameItem entity={protoEntity} />}
        {protoEntity && effectSource === EffectSource.SKILL && <EffectNameSkill entity={protoEntity} />}
        {EffectSource.UNKNOWN == effectSource && `Unknown ${protoEntity}`}
      </div>

      {statmods &&
        statmods.map(({ protoEntity, value }) => (
          <EffectStatmod key={protoEntity} protoEntity={protoEntity} value={value} />
        ))}

      {duration !== undefined && duration.timeValue > 0 && (
        <div className={cls.duration}>
          {"("}
          <span className={cls.timeValue}>{duration.timeValue} </span>
          <span className={cls.timeScope}>{duration.timeScopeName}</span>
          {")"}
        </div>
      )}

      {/* TODO replace with a working button */}
      {/*removability === EffectRemovability.BUFF &&
        <MethodButton name="remove" className="text-sm"
          onClick={() => removeEffect()} />
      */}
    </div>
  );
}
