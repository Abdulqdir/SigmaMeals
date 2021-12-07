import React from "react";

const LandingPage = () => {
  return (
    <div style={{ padding: "20px" }}>
      <h1>Find Better Food</h1>
      <br />
      <p>Your not eating well cuz your poor and sad</p>
      <h3>Let's Change That!</h3>
      <div>
        <a href="/login">
          <button>Login</button>
        </a>
        <a href="/register">
          <button>Register</button>
        </a>
      </div>
    </div>
  );
};

export default LandingPage;