import { ChangeEventHandler } from "react";
import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './Input.module.scss'

type InputProps = {
    value: string;
    placeholder: string;
    onChange?: ChangeEventHandler<HTMLInputElement>;
    className?: string;
};

export default function Input({ onChange, value, placeholder, className }: InputProps) {
  return (
    <input
      placeholder={placeholder}
      value={value}
      onChange={onChange}
      className={classNames(cls.Input, {}, [className])}
    ></input>
  );
}
