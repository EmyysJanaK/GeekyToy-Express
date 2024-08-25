import React, { useEffect, useState } from "react";
import { HiOutlineChevronRight } from "react-icons/hi";
import { useLocation } from "react-router-dom"; //current location info

// Define the 'Breadcrumbs' component that takes 'prevLocation' and 'title' props
const Breadcrumbs = ({ prevLocation, title }) => {

  // Get the current location using the 'useLocation' hook from 'react-router-dom'
  const location = useLocation();
  
  // Initialize 'locationPath' state to store the current location path
  const [locationPath, setLocationPath] = useState("");
  
   // Use the 'useEffect' hook to update 'locationPath' when the 'location' changes
  useEffect(() => {
    setLocationPath(location.pathname.split("/")[1]);
  }, [location]);

  return (
    <div className="w-full py-10 xl:py-10 flex flex-col gap-3">
      <h1 className="text-5xl text-primeColor font-titleFont font-bold">
        {title}
      </h1>
      <p className="text-sm font-normal text-lightText capitalize flex items-center">
        <span> {prevLocation === "" ? "Home" : prevLocation}</span>

        <span className="px-1">
          <HiOutlineChevronRight />
        </span>
        <span className="capitalize font-semibold text-primeColor">
          {locationPath}
        </span>
      </p>
    </div>
  );
};

export default Breadcrumbs;
