import React, { useState } from "react";
import axios from "axios"; // Import axios

const CustomerGuestPage = () => {
  const [formData, setFormData] = useState({
    Password: "",
    First_name: "",
    Last_name: "",
    Email: "",
    Phone_number: "",
    Address_line1: "",
    Address_line2: "",
    City: "",
    Province: "",
    Zipcode: "",
    Is_registered: 0
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({
      ...formData,
      [name]: value,
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    
    // Send a POST request to the API with the form data
    axios.post("http://localhost:8000/register", formData)
      .then((response) => {
        // Handle successful registration (e.g., show a success message)
        console.log("Registration successful:", response.data);
      })
      .catch((error) => {
        // Handle registration error (e.g., show an error message)
        console.error("Registration failed:", error);
      });
  };

  return (
    <div>
      <h1>Guest Details</h1>
      <form onSubmit={handleSubmit}>
      <div>
        </div>
        <div>
          <label>First Name:</label>
          <input
            type="text"
            name="First_name"
            value={formData.First_name}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Last Name:</label>
          <input
            type="text"
            name="Last_name"
            value={formData.Last_name}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Email:</label>
          <input
            type="email"
            name="Email"
            value={formData.Email}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Phone Number:</label>
          <input
            type="tel"
            name="Phone_number"
            value={formData.Phone_number}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Address Line 1:</label>
          <input
            type="text"
            name="Address_line1"
            value={formData.Address_line1}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Address Line 2:</label>
          <input
            type="text"
            name="Address_line2"
            value={formData.Address_line2}
            onChange={handleChange}
          />
        </div>
        <div>
          <label>City:</label>
          <input
            type="text"
            name="City"
            value={formData.City}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Province:</label>
          <input
            type="text"
            name="Province"
            value={formData.Province}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Zipcode:</label>
          <input
            type="text"
            name="Zipcode"
            value={formData.Zipcode}
            onChange={handleChange}
            required
          />
        </div>
        <button type="submit">Add</button>
      </form>
    </div>
  );
};

export default CustomerGuestPage;
