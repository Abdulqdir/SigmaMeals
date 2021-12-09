import { React, useState, useEffect } from "react";
import "../App.css";

const SingleRecipe = () => {
  const [recipe, setRecipe] = useState({});

  const queryParams = new URLSearchParams(window.location.search);
  const id = queryParams.get("id");

  useEffect(() => {
    fetch(`/get_recipe?id=${id}`)
      .then((resp) => resp.json())
      .then((data) => setRecipe(data.result));
  }, [id]);

  console.log(recipe);

  return (
    <div className="single-recipe-container">
      <span className="single-recipe-title">{recipe.recipe_title}</span>
      <div className="recipe-info-container">
        <img src={recipe.image_url} alt="" />
      </div>
    </div>
  );
};

export default SingleRecipe;
