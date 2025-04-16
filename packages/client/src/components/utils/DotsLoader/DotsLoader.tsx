import { useEffect, useState } from "react";

export function DotsLoader({ text = "Loading" }: { text?: string }) {
  const [dots, setDots] = useState("");

  useEffect(() => {
    const interval = setInterval(() => {
      setDots((prev) => {
        if (prev.length >= 3) return ".";
        return prev + ".";
      });
    }, 500);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="text-dark-control text-xl">
      {text}
      <span>{dots}</span>
    </div>
  );
}
