import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './MapsPage.module.scss'

interface MapsPageProps{
  className?: string;
}

const MapsPage = ({className}: MapsPageProps) => {
  return (
    <div className={classNames(cls.MapsPage , {}, [className])}>
      
    </div>
  );
};

export default MapsPage;