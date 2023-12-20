import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './SkillEffectStatmod.module.scss'

interface SkillEffectStatmodProps{
  className?: string;
}

const SkillEffectStatmod = ({className}: SkillEffectStatmodProps) => {
  return (
    <div className={classNames(cls.SkillEffectStatmod , {}, [className])}>

    </div>
  );
};

export default SkillEffectStatmod;