import { React, useState, useEffect } from "react";
// import httpClient from "../httpClient";

const LoginPage = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const logInUser = () => {
    console.log(email, password);

    // Axios stuff
    // try {
    //   const resp = await httpClient.get("//localhost:5000/login", {
    //     email,
    //     password,
    //   });

    //   window.location.href = "/"; //return to landing page if login succeed
    // } catch (error) {
    //   if (error.resp.status === 401) {
    //     alert("Invalid Credential");
    //   }
    // }
  };

  useEffect(() => {
    fetch("/login").then((resp) =>
      resp.json().then((data) => {
        console.log(data);
      })
    );
  }, []);

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
