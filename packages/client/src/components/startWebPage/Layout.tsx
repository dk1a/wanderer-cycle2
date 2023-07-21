import React from "react";
import crypto from "../../utils/img/crypto-tokens.jpeg";
import Card from "./Card";

const Layout = () => {
  return (
    <div className="bg-teal-600 h-full">
      <Card img={crypto} text={"h"} header={"g"} />
    </div>
  );
};

export default Layout;
