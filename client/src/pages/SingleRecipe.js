import { React, useState, useEffect } from 'react';
import '../App.css';

const SingleRecipe = () => {
  const [ingredients, setIngredients] = useState([]);
  const [recipe, setRecipe] = useState({});

  const queryParams = new URLSearchParams(window.location.search);
  const id = queryParams.get('id');

  useEffect(() => {
    fetch(`/get_recipe?id=${id}`)
      .then((resp) => resp.json())
      .then((data) => {
        setIngredients(data.ingredients);
        setRecipe(data.recipe[0]);
      });
  }, [id]);

  return (
    <div className='single-recipe-container'>
      <span className='single-recipe-title'>{recipe.recipe_title}</span>
      <div className='recipe-info-container'>
        <img className='single-recipe-image' src={recipe.image_url} alt='' />
        <div className='ingredients-container'>
          <div style={{ paddingBottom: '20px' }}>
            <span className='ingredient-text'>
              Preparation time: {recipe.prep_time} minutes
            </span>
            <br />
            <span className='ingredient-text'>
              Cost per Serving: ${recipe.recipe_total_cost}
            </span>
          </div>
          <span className='ingredient-text'>Ingredients:</span>
          {ingredients.map((ing) => (
            <li className='ingredient-li' key={ing.ing_name}>
              {ing.quantity} {ing.measurement} of {ing.ing_name}
            </li>
          ))}
          <div className='instructions-container'>
            <span className='ingredient-text'>Instructions:</span>
            {String(recipe.instructions)
              .split('\n')
              .map((str) => (
                <p key={str.charAt(5)}>{str}</p>
              ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default SingleRecipe;
