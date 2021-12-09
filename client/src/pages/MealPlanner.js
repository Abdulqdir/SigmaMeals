import React from 'react';
import { useState, useEffect } from 'react';
import { Table, Row, Col, FloatingLabel, Form, Button } from 'react-bootstrap';
import '../App.css';
import parser from 'html-react-parser';

const MealPlanner = () => {
  const [recipes, setRecipes] = useState([]);
  const [mealType, setMealType] = useState('breakfast');
  const [price, setPrice] = useState(0);

  const openInNewtabSecure = (url) => {
    const newWindow = window.open(url, '_blank', 'noopener,noreferrer');
    if (newWindow) newWindow.opener = null;
  };

  const sendRequest = (mealType, price) => {
    fetch(`/planner?cost=${price}&type=${mealType}`)
      .then((response) => response.json())
      .then((data) => setRecipes(data))
      .catch((err) => console.error(err));
    const arr = [
      {
        recipe_id: 1,
        recipe_title: 'blah blah',
        image_url: '',
        recipe_description: 'descibining stuff',
        recipe_total_cost: 4534,
        rating: 5,
      },
      {
        recipe_id: 2,
        recipe_title: 'blah blah',
        image_url: '',
        recipe_description: 'descibining stuff',
        recipe_total_cost: 4534,
        rating: 5,
      },
      {
        recipe_id: 3,
        recipe_title: 'blah blah',
        image_url: '',
        recipe_description: 'descibining stuff',
        recipe_total_cost: 4534,
        rating: 5,
      },
    ];
    // setRecipes(arr);
  };

  return (
    <div style={{ marginTop: '40px' }} className="browse-recipes-content">
      <Row className="g-2" style={{ width: '70%', margin: 'auto' }}>
        <Col md>
          <FloatingLabel controlId="floatingInputGrid" label="Enter a Price">
            <Form.Control
              type="number"
              placeholder="10"
              onChange={(e) => setPrice(e.target.value)}
            />
          </FloatingLabel>
        </Col>
        <Col md>
          <FloatingLabel controlId="floatingSelectGrid" label="Meal Type">
            <Form.Select
              aria-label="Floating label select example"
              value={mealType}
              onChange={(e) => setMealType(e.target.value)}
            >
              <option value="breakfast">Breakfast</option>
              <option value="lunch">Lunch</option>
              <option value="dinner">Dinner</option>
              <option value="drink">Drink</option>
            </Form.Select>
          </FloatingLabel>
        </Col>
        <Button
          style={{ width: '15%', background: 'rgb(50,50,50)', border: 'none' }}
          onClick={() => sendRequest(mealType, price)}
        >
          Search
        </Button>
      </Row>
      <div style={{ padding: '10px' }}>
        <Table
          striped
          bordered
          hover
          size="sm"
          variant="light"
          style={{ width: '90%', margin: 'auto' }}
        >
          <thead>
            <tr>
              <th>Recipe</th>
              <th>Cost</th>
              <th>Description</th>
              <th>Rating</th>
            </tr>
          </thead>
          <tbody>
            {recipes.map((rep) => (
              <tr
                key={rep.recipe_id}
                onClick={() =>
                  openInNewtabSecure(`/recipe?id=${rep.recipe_id}`)
                }
              >
                <td>
                  <div className="recipe-container">
                    <span className="recipe-title">{rep.recipe_title}</span>
                    <img
                      className="recipe-image"
                      src={rep.image_url}
                      alt=""
                    ></img>
                  </div>
                </td>
                <td className="recipe-cost">${rep.recipe_total_cost}</td>
                <td className="recipe-description">
                  {parser(rep.recipe_description)}
                </td>
                <td className="recipe-rating">{rep.rating}/5</td>
              </tr>
            ))}
          </tbody>
        </Table>
      </div>
    </div>
  );
};

export default MealPlanner;
