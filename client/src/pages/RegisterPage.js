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
       <div style={{ padding: '40px', alignContent:"center" }}>
      <h1>Enter your information</h1>
      <hr></hr>
      <div className="textWr">
      <form>
        <ol>
        <div>
          <label style={{color: 'white'}}>First name: </label>
          <input
            placeholder="first Name"
            type="text"
            value={firstName}
            onChange={(e) => setFirstName(e.target.value)}
            id=""
          />
        </div>
        <br></br>
        <div>
          <label style={{color: 'white'}}>Last name: </label>
          <input
             placeholder="last Name"
            type="text"
            value={lastName}
            onChange={(e) => setLastName(e.target.value)}
            id=""
          />
        </div>
        <br></br>
        <div>
          <label style={{color: 'white'}}>Email: </label>
          <input
             placeholder="email@mail.com"
            type="text"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            id=""
          />
        </div>
        <br></br>
        <div>
          <label style={{color: 'white'}}>Username: </label>
          <input
             placeholder="user Name"
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            id=""
          />
        </div>
        <br></br>
        <div>
          <label style={{color: 'white'}}>Password: </label>
          <input
            placeholder="***********"
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
    </div>
    
  );
};

export default RegisterPage;
