import React from "react";
import { useGuises } from "./mud/hooks/guise";
import { BrowserRouter as Router } from "react-router-dom";
import { Navbar } from "./components/Navbar/Navbar";
import Guise from "./components/Guise/Guise";
import AppRouter from "./AppRouter";
import { useWandererSpawn } from "./mud/hooks/useWandererSpawn";

export const App = () => {
  const guisess = useGuises();
  const wandererSpawn = useWandererSpawn();

  return (
    <Router>
      <div className="app flex justify-center items-center">
        <Navbar
          className={
            "bg-dark-400 border-dark-400 text-dark-300 w-full h-full p-6 flex items-center justify-center"
          }
        />
        <div className="max-w-[1296px]">
          <AppRouter />
        </div>
      </div>

      {guisess.map((guise) => (
        <Guise
          key={guise.entity}
          guise={guise}
          disabled={false}
          onSelectGuise={wandererSpawn}
        />
      ))}
    </Router>
  );
};
