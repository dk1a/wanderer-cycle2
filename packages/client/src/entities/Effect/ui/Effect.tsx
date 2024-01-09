import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './Effect.module.scss'

interface EffectProps{
  className?: string;
}

const Effect = ({className}: EffectProps) => {
  return (
    <div className={classNames(cls.Effect , {}, [className])}>
      
    </div>
  );
};

export default Effect;