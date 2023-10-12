import React, {useState,useEffect} from 'react';
import axios from 'axios';

const ShopPage = () => {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    // Fetch product data from the API when the component mounts
    axios.get('http://localhost:8000/shop')
      .then((response) => {
        console.log(response);
        setProducts(response.data); // Assuming the API returns an array of products
      })
      .catch((error) => {
        console.error('Error fetching data:', error);
      });
  }, []); // The empty dependency array ensures this runs only once on mount

  return (
    <div>
      <h2>Shop</h2>
      <div className="product-list">
        {products.map((product) => (
          <div key={product.Product_id} className="product">
            <h3>{product.Title}</h3>
            <p>Description: {product.Description}</p>
            <img src={product.Image} width="20%"/>
            {/* You can add more product information here */}
            <button onClick={()=>window.location.href=`http://localhost:3000/shop/${product.Product_id}`}>View Product</button>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ShopPage;
