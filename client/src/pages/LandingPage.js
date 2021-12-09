import React from 'react';
import { Button } from 'react-bootstrap';
import '../App.css';
import foodImage from '../components/food.png';

const LandingPage = () => {
  return (
    <div className="landing">
      <div className="landing-wrapper">
        <div className="landing-header">
          <h1>Find Better Foods</h1>
          <h3>while saving money!</h3>
          <br />
          <p className="landing-details">
            One of the biggest issues for students is affording healthy food,
            with 46 percent of community college students and 40 percent of
            four-year college students reporting an inability to pay for
            balanced meals
          </p>
          <br />
          <h4>Let's Change That</h4>
          <div className="button-container">
            <div className="button">
              <Button href="/login" variant="dark">
                Login
              </Button>
            </div>
            <div className="button">
              <Button href="/register" variant="outline-dark">
                Register
              </Button>
            </div>
          </div>
        </div>
        <img className="foodImage" src={foodImage} alt="food" />
      </div>
    </div>
  );
};

export default LandingPage;
