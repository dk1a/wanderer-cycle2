import { useComponentValue } from "@latticexyz/react";
import { useMUD } from "./MUDContext";
import "./App.css";
import StartWebPage from "./components/startWebPage/StartWebPage";

export const App = () => {
  return (
    <div className="h-screen w-screen bg-sky-900">
      <StartWebPage />
    </div>
  );
};
