import { React, useState } from 'react';
import "./register.css";
const RegisterPage = () => {
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  return (
    <div className="register-wrapper">
       <div className="col-md-12 text-center">
       <div style={{ padding: '20px' }}>
      <h1>Enter your information</h1>
      <hr></hr>
      <form>
        <ol>
        <div>
          <label>First name: </label>
          <input
            type="text"
            value={firstName}
            onChange={(e) => setFirstName(e.target.value)}
            id=""
          />
        </div>
        <br></br>
        <div>
          <label>Last name: </label>
          <input
            type="text"
            value={lastName}
            onChange={(e) => setLastName(e.target.value)}
            id=""
          />
        </div>
        <br></br>
        <div>
          <label>Email: </label>
          <input
            type="text"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            id=""
          />
        </div>
        <br></br>
        <div>
          <label>Username: </label>
          <input
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            id=""
          />
        </div>
        <br></br>
        <div>
          <label>Password: </label>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            id=""
          />
        </div>
        <br></br>
        <button type="button">Submit</button>
        </ol>
       
      </form>
    </div>
       </div>
    </div>
    
  );
};

export default RegisterPage;
