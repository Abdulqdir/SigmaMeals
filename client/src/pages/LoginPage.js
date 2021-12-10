import { React, useState } from 'react';
import { Card, FloatingLabel, Form, Button } from 'react-bootstrap';

const LoginPage = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const loginFetch = async () => {
    await fetch('/auth', {
      method: 'GET',
      headers: {
        Authorization: 'Basic ' + btoa(username + ':' + password),
        'Content-Type': 'application/json',
      },
    })
      .then((resp) => {
        if (resp.status === 200) {
          window.location.href = '/';
        } else if (resp.status === 401) {
          alert('Invalid Credential');
        } else {
          alert('Some error occurred');
        }
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <div className='login-form-container'>
      <Card className='login-card'>
        <Card.Body>
          <Card.Title>Welcome back! Please log in</Card.Title>
          <FloatingLabel
            controlId='floatingInput'
            label='Username'
            className='mb-3'
          >
            <Form.Control
              type='username'
              placeholder='username'
              onChange={(e) => setUsername(e.target.value)}
            />
          </FloatingLabel>
          <FloatingLabel
            controlId='floatingInput'
            label='Password'
            className='mb-3'
          >
            <Form.Control
              type='password'
              placeholder='password'
              onChange={(e) => setPassword(e.target.value)}
            />
          </FloatingLabel>
          <Button onClick={() => loginFetch()} variant='outline-dark'>
            Sign in
          </Button>
        </Card.Body>
      </Card>
    </div>
  );
};

export default LoginPage;
