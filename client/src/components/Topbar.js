import { React, useState } from 'react';
import { Container, Form, Navbar, Nav, Col, Button } from 'react-bootstrap';
import '../App.css';
import logo from './logo.png';

export default function Topbar() {
  const [searchKeyword, setSearchKeyword] = useState('');

  return (
    <Navbar bg='light' variant='light'>
      <Container>
        <Navbar.Brand href='/'>
          <img className='sigmameals-logo' src={logo} alt='SigmaMeals Logo' />
        </Navbar.Brand>
        <Nav variant='tabs'>
          <div className='navlink-wrapper'>
            <Nav.Link eventKey='browseRecipes' href='/browseRecipes'>
              Browse recipes
            </Nav.Link>
          </div>
          <div className='navlink-wrapper'>
            <Nav.Link href='mealPlanner' eventKey='mealPlanner'>
              Meal planner
            </Nav.Link>
          </div>
          <div className='navlink-wrapper'>
            <Nav.Link href='aboutUs' eventKey='aboutUs'>
              About us
            </Nav.Link>
          </div>
        </Nav>
        <Navbar.Toggle />
        <Navbar.Collapse className='justify-content-end'>
          <div className='search-bar'>
            <Col xs='auto'>
              <Form.Control
                placeholder='Seach Recipes'
                onChange={(e) => setSearchKeyword(e.target.value)}
              />
            </Col>
            <Button
              href={`/search?recipe_name=${searchKeyword}`}
              variant='dark'
            >
              Submit
            </Button>
          </div>
          <Navbar.Text>
            Join now: <a href='/register'>Sign up</a>
          </Navbar.Text>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
}
