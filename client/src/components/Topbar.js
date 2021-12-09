import React from "react";
import { Container, Navbar, Nav } from "react-bootstrap";
import "./Topbar.css";
import logo from "./logo.png";

export default function Topbar() {
  return (
    <Navbar bg="light" variant="light">
      <Container>
        <Navbar.Brand href="/">
          <img
            src={logo}
            alt="SigmaMeals Logo"
            style={{ width: "auto", height: "110px" }}
          />
        </Navbar.Brand>
        <Nav className="me-auto">
          <div className="navlink-wrapper">
            <Nav.Link href="/browseRecipes">Browse recipes</Nav.Link>
          </div>
          <div className="navlink-wrapper">
            <Nav.Link href="/mealPlanner">Meal planner</Nav.Link>
          </div>
          <div className="navlink-wrapper">
            <Nav.Link href="/aboutUs">About us</Nav.Link>
          </div>
        </Nav>
        <Navbar.Toggle />
        <Navbar.Collapse className="justify-content-end">
          <Navbar.Text>
            Join now: <a href="/login">Sign up</a>
          </Navbar.Text>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
}
