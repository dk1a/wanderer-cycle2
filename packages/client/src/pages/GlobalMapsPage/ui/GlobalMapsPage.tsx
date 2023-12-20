import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './GlobalMapsPage.module.scss'

interface GlobalMapsPageProps{
  className?: string;
}

const GlobalMapsPage = ({className}: GlobalMapsPageProps) => {
  return (
    <div className={classNames(cls.GlobalMapsPage , {}, [className])}>
      
    </div>
  );
};

export default GlobalMapsPage;