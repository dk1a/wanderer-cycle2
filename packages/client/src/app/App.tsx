import {Navbar} from "@/widgets/Navbar";
import AppRouter from "@/app/providers/router/ui/AppRouter";
import { BrowserRouter as Router } from 'react-router-dom';
import {Sidebar} from "@/widgets/Sidebar";
import {Guise} from "@/entities/Guise";
import {useState} from "react";

export const App = () => {
  const [leftSidebarOpen, setLeftSidebarOpen] = useState(true);
  const [rightSidebarOpen, setRightSidebarOpen] = useState(true);

  const leftSidebarWidth = leftSidebarOpen ? 'var(--sidebar-width)' : 'var(--sidebar-width-collapsed)';
  const rightSidebarWidth = rightSidebarOpen ? 'var(--sidebar-width)' : 'var(--sidebar-width-collapsed)';

  return (
    <Router>
      <div className='app'>
        <Navbar/>
        <Sidebar position='left' setSidebarOpen={setLeftSidebarOpen}/>
        <div className='main-content' style={{ marginLeft: leftSidebarWidth, marginRight: rightSidebarWidth }}>
          <AppRouter/>
          <Guise />
          {/* Основной контент */}
        </div>
        <Sidebar position='right' setSidebarOpen={setRightSidebarOpen}/>
      </div>
    </Router>
  );
};
