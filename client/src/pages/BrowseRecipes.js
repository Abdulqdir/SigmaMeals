import React from "react";
import { useState, useEffect } from "react";
import { Table } from "react-bootstrap";
import "./BrowseRecipes.css";
import parser from "html-react-parser";

const BrowseRecipes = () => {
  const [recipes, setRecipes] = useState([]);

  useEffect(() => {
    fetch("/Browse")
      .then((resp) => resp.json())
      .then((data) => setRecipes(data.result));
  }, []);

  return (
    <div className="browse-recipes-content">
      <Table striped bordered hover size="sm" variant="dark">
        <thead>
          <tr>
            <th>Recipe</th>
            <th>Cost</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          {recipes.map((rep) => (
            <tr key={rep.recipe_id} onClick={() => console.log("test")}>
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
            </tr>
          ))}
        </tbody>
      </Table>
    </div>
  );
};

export default BrowseRecipes;
