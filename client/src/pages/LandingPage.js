import React from "react";
import { Button } from "react-bootstrap";
import "../App.css";

const LandingPage = () => {
  return (
    <div className="landing-wrapper">
      <div className="landing-header">
        <h1>Find Better Foods</h1>
        <h3>while saving money!</h3>
      </div>
      <br />
      <p className="landing-details">
        One of the biggest issues for students is affording healthy food, with
        46 percent of community college students and 40 percent of four-year
        college students reporting an inability to pay for balanced meals
      </p>
      <br />
      <h4>Let's Change That!</h4>
      <div>
        <Button className="login-button" href="/login" variant="dark">
          Login
        </Button>
        <Button
          className="register-button"
          href="/register"
          variant="outline-dark"
        >
          Register
        </Button>
        {/* <a href="/login">
          <button>Login</button>
        </a>
        <a href="/register">
          <button>Register</button>
        </a> */}
      </div>
    </div>
  );
};

export default LandingPage;
