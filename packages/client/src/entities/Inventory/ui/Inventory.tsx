import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './Inventory.module.scss'

interface InventoryProps{
  className?: string;
}

const Inventory = ({className}: InventoryProps) => {
  return (
    <div className={classNames(cls.Inventory , {}, [className])}>

    </div>
  );
};

export default Inventory;