import React from "react";
import { Container, Navbar } from "react-bootstrap";
import "./Topbar.css";

export default function Topbar() {
  return (
    <Navbar>
      <Container>
        <Navbar.Brand href="/">
          <img src="logo.png" alt="SigmaMeals Logo" />
        </Navbar.Brand>
        <Navbar.Toggle />
        <Navbar.Collapse className="justify-content-end">
          <Navbar.Text>
            Signed in as: <a href="/login">username</a>
          </Navbar.Text>
        </Navbar.Collapse>
      </Container>
    </Navbar>

    // {/* <div className="topbar">
    //   <div className="topbarWrapper">
    //     <div className="topLeft">
    //       <span className="logo">Logo Here</span>
    //     </div>
    //     <div className="topRight">
    //       <span className="account">User Account here</span>
    //     </div>
    //   </div>
    // </div> */}
  );
}
