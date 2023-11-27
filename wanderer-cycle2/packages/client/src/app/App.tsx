import {Navbar} from "@/widgets/Navbar";
import AppRouter from "@/app/providers/router/ui/AppRouter";
import { BrowserRouter as Router } from 'react-router-dom';

export const App = () => {
  return (
    <Router>
      <Navbar/>
      <AppRouter/>
    </Router>
  );
};
