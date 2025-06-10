import React from "react";
import { ToastContainer } from "react-toastify";

// Default implementation, that you can customize
export default function Root({ children }) {
  return (
    <>
      {children}
      <ToastContainer />
    </>
  );
}
