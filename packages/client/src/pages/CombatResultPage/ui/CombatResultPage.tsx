import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './CombatResultPage.module.scss'

interface CombatResultPageProps{
  className?: string;
}

const CombatResultPage = ({className}: CombatResultPageProps) => {
  return (
    <div className={classNames(cls.CombatResultPage , {}, [className])}>
      
    </div>
  );
};

export default CombatResultPage;