import React from "react";
import ReactDOM from "react-dom";
import "./index.css";
import "bootstrap/dist/css/bootstrap.min.css";
// import App from "./App";
import { Router } from "./Router";

ReactDOM.render(
  <React.StrictMode>
    {/* <App /> */}
    {/* REMOVE THIS WHEN U HAVE A PROPER NAVBAR  */}
    <div style={{ display: "flex" }}>
      <a href="/" style={{ padding: "20px" }}>
        <p>Home</p>
      </a>
      <a href="/browseRecipes" style={{ padding: "20px" }}>
        <p>Browse Recipes</p>
      </a>
    </div>
    {/* REMOVE THIS WHEN U HAVE A PROPER NAVBAR  */}

    <Router />
  </React.StrictMode>,
  document.getElementById("root")
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
