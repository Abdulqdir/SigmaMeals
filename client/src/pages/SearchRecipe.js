import React from 'react';
import { useState, useEffect } from 'react';
import { Table } from 'react-bootstrap';
import '../App.css';
import parser from 'html-react-parser';

const SearchRecipes = () => {
  const [recipes, setRecipes] = useState([]);

  const queryParams = new URLSearchParams(window.location.search);
  const keyword = queryParams.get('recipe_name');

  useEffect(() => {
    fetch(`/search?recipe_name=${keyword}`)
      .then((resp) => resp.json())
      .then((data) => {
        setRecipes(data);
      });
  }, [keyword]);

  const openInNewtabSecure = (url) => {
    const newWindow = window.open(url, '_blank', 'noopener,noreferrer');
    if (newWindow) newWindow.opener = null;
  };

  // console.log(recipes);

  return (
    <div className='browse-recipes-content'>
      <Table striped bordered hover size='sm' variant='light'>
        <thead>
          <tr>
            <th>Recipe</th>
            <th>Cost</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          {recipes.map((rep) => (
            <tr
              key={rep.recipe_id}
              onClick={() => openInNewtabSecure(`/recipe?id=${rep.recipe_id}`)}
            >
              <td>
                <div className='recipe-container'>
                  <span className='recipe-title'>{rep.recipe_title}</span>
                  <img
                    className='recipe-image'
                    src={rep.image_url}
                    alt=''
                  ></img>
                </div>
              </td>
              <td className='recipe-cost'>${rep.recipe_total_cost}</td>
              <td className='recipe-description'>
                {parser(rep.recipe_description)}
              </td>
            </tr>
          ))}
        </tbody>
      </Table>
    </div>
  );
};

export default SearchRecipes;
