import React from "react";
import "./Topbar.css";

export default function Topbar() {
  return (
    <div className="topbar">
      <div className="topbarWrapper">
        <div className="topLeft">
          <span className="logo">Logo Here</span>
        </div>
        <div className="topRight">
          <span className="account">User Account here</span>
        </div>
      </div>
    </div>
  );
}