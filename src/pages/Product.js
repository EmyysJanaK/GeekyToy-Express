import React, { useState, useEffect } from "react";
import axios from "axios";
import { useParams } from "react-router-dom";

const ProductPage = () => {
  const { id } = useParams(); // Get the product ID from the URL parameter
  const [product, setProduct] = useState({});
  const [cart, setCart] = useState([]);

  useEffect(() => {
    // Fetch product details from the API
    axios.get(`http://localhost:8000/shop/${id}`)
      .then((response) => {
        console.log(response);
        setProduct(response.data[0]);
      })
      .catch((error) => {
        console.error("Error fetching product details:", error);
      });
  }, [id]);

  const addToCart = () => {
    // Add the selected product to the cart
    setCart([...cart, product]);
  };

  return (
    <div>
      <h1>{product.Title}</h1>
      <img src={product.Image} width="25%" />
      <p>{product.Description}</p>
      <p>{product.Weight}</p>
      <p>Price: $100</p>
      <button onClick={addToCart}>Add to Cart</button>
    </div>
  );
};

export default ProductPage;
