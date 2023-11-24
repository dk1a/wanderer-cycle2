import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './SkillPage.module.scss'

interface SkillPageProps{
  className?: string;
}

const SkillPage = ({className}: SkillPageProps) => {
  return (
    <div className={classNames(cls.SkillPage , {}, [className])}>
      
    </div>
  );
};

export default SkillPage;