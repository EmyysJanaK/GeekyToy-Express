import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';

const HomePage = () => {
  const [categories, setCategories] = useState([]);

  useEffect(() => {
    // Fetch main product categories from the API when the component mounts
    axios.get('http://localhost:8000/main-categories')
      .then((response) => {
        console.log(response);
        setCategories(response.data); // Assuming the API returns an array of categories
      })
      .catch((error) => {
        console.error('Error fetching categories:', error);
      });
  }, []); // The empty dependency array ensures this runs only once on mount

  return (
    <div className="slider">
      {categories.map((category) => (
        <a href={`/main-categories/${category.Main_category_id}`}
          //to={`/main-categories/`} // Assuming the API uses 'id' for category identification
          key={category.Main_category_id}
          className="category-slide"
        >
          <img src={category.Image} alt={category.Name} width="60%" 
                    style={{'marginLeft':'20%', 'marginRight':'20%'}} />
          <h3 style={{'textAlign':'center'}}>{category.Name}</h3>
        </a>
      ))}
    </div>
  );
};

export default HomePage;
