import { React, useState } from "react";
import httpClient from "../httpClient";

const LoginPage = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const logInUser = async () => {
    console.log(email, password);

    try {
      const resp = await httpClient.get("//localhost:5000/login", {
        email,
        password,
      });

      window.location.href = "/"; //return to landing page if login succeed
    } catch (error) {
      if (error.resp.status === 401) {
        alert("Invalid Credential");
      }
    }
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>Please log in</h1>
      <form>
        <div>
          <label>Email: </label>,
          <input
            type="text"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            id=""
          />
        </div>
        <div>
          <label>Password: </label>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            id=""
          />
        </div>
        <button type="button" onClick={() => logInUser()}>
          Submit
        </button>
      </form>
    </div>
  );
};

export default LoginPage;
