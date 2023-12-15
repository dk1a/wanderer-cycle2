import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './GuiseSkill.module.scss'

interface GuiseSkillProps{
  className?: string;
}

const GuiseSkill = ({className}: GuiseSkillProps) => {
  return (
    <div className={classNames(cls.GuiseSkill , {}, [className])}>
      
    </div>
  );
};

export default GuiseSkill;