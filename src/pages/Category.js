import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useParams } from 'react-router-dom';

const CategoryProducts = () => {
  const { id } = useParams(); // Get the category ID from the URL parameter
  const [products, setProducts] = useState([]);

  useEffect(() => {
    // Fetch products belonging to the specified category from the API
    axios.get(`http://localhost:8000/main-categories/${id}`)
      .then((response) => {
        console.log(response);
        setProducts(response.data); // Assuming the API returns an array of products
      })
      .catch((error) => {
        console.error('Error fetching products:', error);
      });
  }, [id]); // Re-fetch when the category ID changes

  return (
    <div>
      <h2>Products in Category {id}</h2>
      <div className="product-list">
        {products.map((product) => (
          <div key={product.Product_id} className="product">
            <img src={product.Image} width="25%"/>
            <h3>{product.Title}</h3>
            <p>{product.Description}</p>
            {/* Add more product information here */}
            <button onClick={()=>window.location.href=`http://localhost:3000/shop/${product.Product_id}`}>View Product</button>
          </div>
        ))}
      </div>
    </div>
  );
};

export default CategoryProducts;
