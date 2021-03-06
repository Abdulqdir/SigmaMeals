import React from 'react';
import { useState } from 'react';
import { Table, Row, Col, FloatingLabel, Form, Button } from 'react-bootstrap';
import '../App.css';
import parser from 'html-react-parser';

const MealPlanner = () => {
  const [recipes, setRecipes] = useState([]);
  const [mealType, setMealType] = useState('Breakfast');
  const [price, setPrice] = useState(0);

  const openInNewtabSecure = (url) => {
    const newWindow = window.open(url, '_blank', 'noopener,noreferrer');
    if (newWindow) newWindow.opener = null;
  };

  const sendRequest = (mealType, price) => {
    fetch(`/planner?cost=${price}&mealtype=${mealType}`)
      .then((res) => res.json())
      .then((data) => {
        setRecipes(data.result);
      })
      .catch((err) => console.error(err));
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
              <option value="Breakfast">Breakfast</option>
              <option value="Lunch">Lunch</option>
              <option value="Dinner">Dinner</option>
              <option value="Drink">Drink</option>
            </Form.Select>
          </FloatingLabel>
        </Col>
        <Button
          style={{ width: '15%', background: 'rgb(50,50,50)', border: 'none' }}
          onClick={() => sendRequest(mealType, price)}
        >
          Build Plan
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
