import { useStatmodPrototype } from "../../mud/hooks/useStatmodPrototype";
import { EffectStatmodData } from "../../mud/utils/effectStatmod";
import cls from "./Effect.module.scss";
import {classNames} from "@/shared/lib/classNames/classNames";

interface EffectStatmodProps{
  className?: string;
}
export function EffectStatmod({ protoEntity, value }: EffectStatmodData) {
  const statmodPrototype = useStatmodPrototype(protoEntity);
  const name = statmodPrototype.name;
  const nameParts = name.split("#");
  return (
    <div className={cls.Statmod}>
      {nameParts.map((namePart, index) => (
        <div key={namePart} className={cls.name}>
          {index !== 0 && <span>{value}</span>}
          <span className={cls.namePart}>{namePart}</span>
        </div>
      ))}
    </div>
  );
}
