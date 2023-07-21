import React from "react";

const Card = ({
  header,
  text,
  img,
}: {
  header: string;
  text: string;
  img: string;
}) => {
  return (
    <div className="flex justify-around items-center ">
      <div className="flex flex-col w-1/2">
        <h1 className="mb-5">{header}</h1>
        <div>{text}</div>
      </div>
      <img src={img} alt="matrix" className="w-36 h-36" />
    </div>
  );
};

export default Card;
