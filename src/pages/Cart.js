import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useParams } from "react-router-dom";

const CartPage = () => {
  const { id } = useParams(); // Get the customer ID from the URL parameter
  const [cartItems, setCartItems] = useState([]);
  const [totalValue, setTotalValue] = useState(0);

  useEffect(() => {
    // Fetch cart items data from the API
    axios.get(`http://localhost:8000/cart/${id}`)
      .then((response) => {
        // Handle the API response and extract cart items data
        const cartData = response.data;
        console.log(cartData);

        // Calculate the total value
        let total = 0;
        for (const item of cartData) {
          total += item.price * item.quantity;
        }

        // Set the state with cart items and total value
        setCartItems(cartData);
        setTotalValue(total);
      })
      .catch((error) => {
        console.error('Error fetching cart data:', error);
      });
  }, [id]);

  return (
    <div>
      <h2>Your Cart</h2>
      {cartItems.length === 0 ? (
        <p>Your cart is empty.</p>
      ) : (
    <div>
      <table>
        <thead>
          <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>
          </tr>
        </thead>
        <tbody>
          {cartItems.map((item, index) => (
            <tr key={index}>
              <td>{item.title}</td>
              <td>${item.price}</td>
              <td>{item.quantity}</td>
              <td>${item.price * item.quantity}</td>
            </tr>
          ))}
        </tbody>
      </table>
      <p>Total Value: ${totalValue.toFixed(2)}</p>
      </div>
      )}
    </div>
  );
}

export default CartPage;
