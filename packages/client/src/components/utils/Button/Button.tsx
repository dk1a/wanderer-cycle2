import { ButtonHTMLAttributes, FC } from "react";

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  className?: string;
  square?: boolean;
  disabled?: boolean;
}

export const Button: FC<ButtonProps> = (props) => {
  const { className, children, disabled, ...otherProps } = props;

  return (
    <button
      type="button"
      disabled={disabled}
      className={className}
      {...otherProps}
    >
      {children}
    </button>
  );
};
