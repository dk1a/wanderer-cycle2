import { classNames } from '@/shared/lib/classNames/classNames';
import { useState } from 'react';
import cls from './Sidebar.module.scss';
import {Button} from "@/shared/ui/Button/Button";

interface SidebarProps {
  className?: string;
  position: 'left' | 'right';
  setSidebarOpen: (isOpen: boolean) => void;
}

export const Sidebar = ({ className, position, setSidebarOpen }: SidebarProps) => {
  const [collapsed, setCollapsed] = useState(false);

  const onToggle = () => {
    const newCollapsedState = !collapsed;
    setCollapsed(newCollapsedState);
    setSidebarOpen(!newCollapsedState);
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
