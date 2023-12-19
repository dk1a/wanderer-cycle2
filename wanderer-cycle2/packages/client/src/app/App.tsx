import {Navbar} from "@/widgets/Navbar";
import AppRouter from "@/app/providers/router/ui/AppRouter";
import { BrowserRouter as Router } from 'react-router-dom';
import {Sidebar} from "@/widgets/Sidebar";
import {Guise} from "@/entities/Guise";

export const App = () => {
  return (
    <Router>
      <div className={'app'}>
        <Navbar/>
        <Guise/>
        {/*<Sidebar position={"left"}/>*/}
        {/*<Sidebar position={"right"}/>*/}
        <AppRouter/>
      </div>
    </Router>
  );
};
