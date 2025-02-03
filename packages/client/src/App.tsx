import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import { Navbar } from "./components/Navbar/Navbar";
import AppRouter from "./AppRouter";
import { useMUD } from "./MUDContext";

export const App = () => {
  console.log(useMUD());
  return (
    <Router>
      <div className="app flex flex-col min-h-screen">
        <Navbar className="bg-dark-400 border-dark-400 text-dark-300 p-6 flex items-center justify-center w-full fixed top-0 left-0 z-40 transition-all duration-300" />
        <div className="flex-1 pt-16 overflow-auto">
          <AppRouter />
        </div>
      </div>
    </Router>
  );
};
