import React from "react";
import { useState, useEffect } from "react";
import { Table } from "react-bootstrap";

const BrowseRecipes = () => {
  const [recipes, setRecipes] = useState([]);

  useEffect(() => {
    fetch("/Browse")
      .then((resp) => resp.json())
      .then((data) => setRecipes(data.result));
  }, []);

  return (
    <React.Fragment>
      <h1>Browse Recipes</h1>
      <Table striped bordered hover size="sm" variant="dark">
        <thead>
          <tr>
            <th> </th>
            <th>Title</th>
            <th>Description</th>
            <th>Instruction</th>
            <th>Cost</th>
          </tr>
        </thead>
        <tbody>
          {recipes.map((rep) => (
            <tr key={rep.recipe_id}>
              <td>
                <img
                  src={rep.image_url}
                  alt=""
                  style={{ width: "auto", height: "240px" }}
                ></img>
              </td>
              <td>{rep.recipe_title}</td>
              <td>{rep.recipe_description}</td>
              <td>{rep.instructions}</td>
              <td>${rep.recipe_total_cost}</td>
            </tr>
          ))}
        </tbody>
      </Table>
    </React.Fragment>
  );
};

export default BrowseRecipes;
