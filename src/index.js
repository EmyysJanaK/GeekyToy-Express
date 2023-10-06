import React from "react";
import ReactDOM from "react-dom/client";
import { PersistGate } from "redux-persist/integration/react";
import "slick-carousel/slick/slick.css";
import { Provider } from "react-redux";
import { store, persistor } from "./redux/store";
import "./index.css";
import App from "./App";

//Create react root instance, and specify DOM Elment with id="root"
const root = ReactDOM.createRoot(document.getElementById("root"));
// Render the root component, which is wrapped with Redux and Redux Persist configuration
root.render(
  <Provider store={store}>
    <PersistGate loading={null} persistor={persistor}>
      <App />
    </PersistGate>
  </Provider>
);
