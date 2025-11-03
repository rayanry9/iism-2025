import React, { createContext, ReactNode, useState } from "react";

type RegisterData = {
  fullName: string;
  age: string;
  phone: string;
  university: string;
  sport: string;
  email: string;
  password: string;
  confirmPassword: string;
  verificationCode: string;
};

type RegisterContextType = {
  data: RegisterData;
  setData: React.Dispatch<React.SetStateAction<RegisterData>>;
};

export const RegisterContext = createContext<RegisterContextType | undefined>(
  undefined
);

export function RegisterProvider({ children }: { children: ReactNode }) {
  const [data, setData] = useState<RegisterData>({
    fullName: "",
    age: "",
    phone: "",
    university: "",
    sport: "",
    email: "",
    password: "",
    confirmPassword: "",
    verificationCode: "",
  });
  return (
    <RegisterContext.Provider value={{ data, setData }}>
      {children}
    </RegisterContext.Provider>
  );
}
