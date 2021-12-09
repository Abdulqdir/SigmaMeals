import React from "react";
import ReactDOM from "react-dom";
import "./App.css";
import "bootstrap/dist/css/bootstrap.min.css";
// import App from "./App";
import { Router } from "./Router";
import Topbar from "./components/Topbar";

ReactDOM.render(
  <React.StrictMode>
    {/* <App /> */}
    <Topbar />
    <Router />
  </React.StrictMode>,
  document.getElementById("root")
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
