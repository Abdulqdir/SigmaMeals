import React from 'react';
import { useState, useEffect } from 'react';
import { Table, Form } from 'react-bootstrap';
import '../App.css';
import parser from 'html-react-parser';

const BrowseRecipes = () => {
  const [recipes, setRecipes] = useState([]);
  const [breakfast, setBreakfast] = useState(false);
  const [lunch, setLunch] = useState(false);
  const [dinner, setDinner] = useState(false);
  const [drink, setDrink] = useState(false);

  useEffect(() => {
    let query = '/Browse?';
    if (breakfast) query += 'param1=Breakfast&';
    if (lunch) query += 'param2=Lunch&';
    if (dinner) query += 'param3=Dinner&';
    if (drink) query += 'param4=Drink&';
    fetch(query)
      .then((resp) => resp.json())
      .then((data) => setRecipes(data.result))
      .catch((err) => console.error(err));
  }, [breakfast, lunch, dinner, drink]);

  const openInNewtabSecure = (url) => {
    const newWindow = window.open(url, '_blank', 'noopener,noreferrer');
    if (newWindow) newWindow.opener = null;
  };

  return (
    <div className="browse-recipes-content">
      <div className="filter">
        <span>Filter by meal type:</span>
        <Form>
          <div className="mb-3">
            <Form.Check
              inline
              label="Breakfast"
              name="group1"
              type="checkbox"
              id="inline-checkbox-breakfast"
              onChange={() => setBreakfast(!breakfast)}
            />
            <Form.Check
              inline
              label="Lunch"
              name="group1"
              type="checkbox"
              id="inline-checkbox-lunch"
              onChange={() => setLunch(!lunch)}
            />
            <Form.Check
              inline
              label="Dinner"
              name="group1"
              type="checkbox"
              id="inline-checkbox-dinner"
              onChange={() => setDinner(!dinner)}
            />
            <Form.Check
              inline
              label="Drink"
              name="group1"
              type="checkbox"
              id="inline-checkbox-drink"
              onChange={() => setDrink(!drink)}
            />
          </div>
        </Form>
      </div>
      <Table striped bordered hover size="sm" variant="light">
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
              key={rep.recipe_id + ',' + rep.recipe_title}
              onClick={() => openInNewtabSecure(`/recipe?id=${rep.recipe_id}`)}
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
  );
};

export default BrowseRecipes;
