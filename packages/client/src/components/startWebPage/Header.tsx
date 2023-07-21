import React from "react";
import sword from "../../utils/img/sword.svg";
import helmet from "../../utils/img/helmet.svg";
import shield from "../../utils/img/shield.svg";
import HRef from "./HRef";

const Header = () => {
  return (
    <div className="flex items-center justify-center flex-col w-full h-full">
      <HRef />
      <div className="flex w-36 justify-around">
        <img src={sword} alt="sword" className="w-10 h-14" />
        <img src={helmet} alt="sword" className="w-10 h-14" />
        <img src={shield} alt="sword" className="w-10 h-14" />
      </div>
      <h1 className="flex justify-center items-center text-8xl text-cyan-200">
        WANDERER-CYCLE
      </h1>
      <div className="flex justify-around w-1/4 mt-10">
        <button className="bg-sky-900 text-cyan-200 py-2 px-4 rounded-none transition-colors duration-500 hover:bg-cyan-200 hover:text-dark-highlight">
          PLay
        </button>
        <button className="bg-sky-900 text-cyan-200 py-2 px-4 rounded-none transition-colors duration-500 hover:bg-cyan-200 hover:text-dark-highlight ">
          READ
        </button>
      </div>
    </div>
  );
};

export default Header;
