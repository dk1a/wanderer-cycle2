import {Navbar} from "@/widgets/Navbar";
import AppRouter from "@/app/providers/router/ui/AppRouter";
import { BrowserRouter as Router } from 'react-router-dom';
import {Sidebar} from "@/widgets/Sidebar";

export const App = () => {
  return (
    <Router>
      <div className={'app'}>
        <Navbar/>
        <Sidebar position={"left"}/>
        <Sidebar position={"right"}/>
        <AppRouter/>
      </div>
    </Router>
  );
};
