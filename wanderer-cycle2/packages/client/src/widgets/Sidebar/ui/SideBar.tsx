import { classNames } from '@/shared/lib/classNames/classNames';
import { useState } from 'react';
import cls from './Sidebar.module.scss';
import {Button} from "@/shared/ui/Button/Button";

interface SidebarProps {
  className?: string;
  position: 'left' | 'right'
}

export const Sidebar = ({ className, position }: SidebarProps) => {
  const [collapsed, setCollapsed] = useState(false);

  const onToggle = () => {
    setCollapsed((prev) => !prev);
  };

  const sidebarClasses = classNames(
    cls.Sidebar,
    {
      [cls.collapsed]: collapsed,
      [cls.left]: position === 'left',
      [cls.right]: position === 'right',
    },
    [className]
  );

  return (
    <div className={sidebarClasses}>
      <Button
        onClick={onToggle}
        className={cls.collapseBtn}
      >
        {collapsed ? 'open' : 'close'}
      </Button>
    </div>
  );
};
