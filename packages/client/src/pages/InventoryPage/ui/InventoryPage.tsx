import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './InventoryPage.module.scss'

interface InventoryPageProps{
  className?: string;
}

const InventoryPage = ({className}: InventoryPageProps) => {
  return (
    <div className={classNames(cls.InventoryPage , {}, [className])}>
      
    </div>
  );
};

export default InventoryPage;