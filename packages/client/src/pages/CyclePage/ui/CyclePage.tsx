import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './CyclePage.module.scss'

interface CyclePageProps{
  className?: string;
}

const CyclePage = ({className}: CyclePageProps) => {
  return (
    <div className={classNames(cls.CyclePage , {}, [className])}>
      
    </div>
  );
};

export default CyclePage;