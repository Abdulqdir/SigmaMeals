import React from "react";
import { Container, Navbar } from "react-bootstrap";
import Nav from "react-bootstrap/Nav";
import "../App.css";
import logo from "./logo.png";

export default function Topbar() {
  return (
    <Navbar bg="light" variant="light">
      <Container>
        <Navbar.Brand href="/">
          <img className="sigmameals-logo" src={logo} alt="SigmaMeals Logo" />
        </Navbar.Brand>
        <Nav variant="tabs">
          <div className="navlink-wrapper">
            <Nav.Link eventKey="browseRecipes" href="/browseRecipes">
              Browse recipes
            </Nav.Link>
          </div>
          <div className="navlink-wrapper">
            <Nav.Link href="mealPlanner" eventKey="mealPlanner">
              Meal planner
            </Nav.Link>
          </div>
          <div className="navlink-wrapper">
            <Nav.Link href="aboutUs" eventKey="aboutUs">
              About us
            </Nav.Link>
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
