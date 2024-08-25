import React from "react";

// Define a functional component called 'Badge' that takes a 'text' prop.
const Badge = ({ text }) => {
  return (
    // Return a 'div' element with specific CSS classes for styling.
    <div className="bg-primeColor w-[92px] h-[35px] text-white flex justify-center items-center text-base font-semibold hover:bg-black duration-300 cursor-pointer">
      {text}
    </div>
  );
};

export default Badge;
