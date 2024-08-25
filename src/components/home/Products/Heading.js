import React from "react";

// Define a functional component called 'Heading' that takes a 'heading' prop.
const Heading = ({ heading }) => {
  return <div className="text-3xl font-semibold pb-6">{heading}</div>;
};

export default Heading;
