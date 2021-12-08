import { React, useState } from "react";
// import httpClient from "../httpClient";

const LoginPage = () => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  // const loginAxios = async () => {
  //   // Axios stuff
  //   try {
  //     const resp = await httpClient.post("//127.0.0.1:5000/login", {
  //       username,
  //       password,
  //     });

  //     // redirect to landing page if no errors
  //     window.location.href = "/";
  //   } catch (error) {
  //     if (error.response.status === 401) {
  //       alert("Invalid Credential");
  //     }
  //   }
  // };

  const loginFetch = async () => {
    await fetch("/auth", {
      method: "GET",
      headers: {
        Authorization: "Basic " + username + ":" + password,
        "Content-Type": "application/json",
      },
      // body: JSON.stringify({ username: username, password: password }),
    })
      .then((resp) => {
        if (resp.status === 200) {
          window.location.href = "/";
        } else if (resp.status === 401) {
          alert("Invalid Credential");
        }
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>Please log in</h1>
      <form>
        <div>
          <label>Username: </label>
          <input
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
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
        <button type="button" onClick={() => loginFetch()}>
          Submit
        </button>
      </form>
    </div>
  );
};

export default LoginPage;
