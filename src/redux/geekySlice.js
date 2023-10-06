import { createSlice } from "@reduxjs/toolkit";

// Define the initial state of the Redux store
const initialState = {
  userInfo: [],
  products: [],
};

// Create a Redux slice named 'geeky'
export const geekySlice = createSlice({
  name: "geeky",
  initialState, // Initial state defined above
  reducers: {
    // Action to add an item to the cart
    addToCart: (state, action) => {
      // Find the item in the products array by its _id
      const item = state.products.find(
        (item) => item._id === action.payload._id
      );
      if (item) {
        // If the item already exists in the cart, increase its quantity
        item.quantity += action.payload.quantity;
      } else {
        // If the item is not in the cart, add it
        state.products.push(action.payload);
      }
    },
    // Action to increase the quantity of an item in the cart
    increaseQuantity: (state, action) => {
      const item = state.products.find(
        (item) => item._id === action.payload._id
      );
      if (item) {
        item.quantity++;
      }
    },
    drecreaseQuantity: (state, action) => {
      const item = state.products.find(
        (item) => item._id === action.payload._id
      );
      if (item.quantity === 1) {
        item.quantity = 1;
      } else {
        item.quantity--;
      }
    },
    deleteItem: (state, action) => {
      // Filter out the item with the specified _id from the products array
      state.products = state.products.filter(
        (item) => item._id !== action.payload
      );
    },
    // Action to reset the entire cart
    resetCart: (state) => {
      // Clear the products array, effectively resetting the cart
      state.products = [];
    },
  },
});

// Export individual action creators
export const {
  addToCart,
  increaseQuantity,
  drecreaseQuantity,
  deleteItem,
  resetCart,
} = geekySlice.actions;

// Export the reducer function
export default geekySlice.reducer;
