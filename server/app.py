'''
App.py sets up all the routes for the front-end. It takes inputs and responds to all the front-end requests as needed.
Authors: Abdulqadir Ibrahim, Artem Potafiy, Lam Mai, Ruchik Chaudhari
Date: 12/10/2021
Version: Winter 2021 
'''
import os
from flask import Flask, request, json, jsonify, send_from_directory
from flask_sqlalchemy import SQLAlchemy
from module import *

# create flask instance
app = Flask(__name__, static_folder='../client/build')
# add database
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://gtbbojbdpfuvny:d763d0bf441b5a29c4fa6542b26502e7934ea733ad4bfcb02d7903bcd7affca6@ec2-3-95-130-249.compute-1.amazonaws.com:5432/d7s9m35lp1c3ph"
# create tables/intialise the database
db = SQLAlchemy(app)


'''
create_user method is for route /create_user which accepts POST requests.
It takes all the user details and performs an entry into database (USERS Table).
It restricts duplicate user entries.

INPUT: 
   User information through request body

OUTPUT: 
   On a succesful entry it sends back 200 with a message of username  
   If user already exists then 401 with a message of 'User exists'
   In all other cases 406 with a message 'not added'
'''
@app.route('/create_user', methods=['post'])
def create_user():
    #get all the user info from the request body
    req = request.json
    first_name = req.get('first_name')
    last_name = req.get('last_name')
    email = req.get('email')
    user_name = req.get('user_name')
    password = req.get('password')

    #perform a query to database to see if the user already exists
    result = db.engine.execute(
        'SELECT username FROM USERS WHERE USERS.firstname = \'{}\' AND USERS.username = \'{}\' '.format(first_name, user_name)).first()

    # send a proper respone based on different scenarios
    if result is None:
        db.engine.execute( # query to add the user to database
            '''INSERT INTO USERS(firstname, lastname, username, email, password)
            VALUES(\'{}\',\'{}\',\'{}\',\'{}\',\'{}\')'''.format(first_name, last_name, user_name, email, password))
        user = db.engine.execute(
            'SELECT username FROM USERS WHERE USERS.firstname = \'{}\' AND USERS.username = \'{}\''.format(first_name, user_name)).first()
        if user is None:
            return {"user": "not added"}, 406
        else:
            return {"user_name": user.username}, 200
    else:
        return {"user": 'User exists'}, 401


'''
login method is setup for /auth which accepts 'GET' requests.
It checks if the user exists in the database or not

INPUT:
    Username and Password through request

OUTPUT:
    if user exists, send a secret token
    In any other case, send 401 with an error message
'''
@app.route("/auth", methods=['GET'])
def login():
    #get the user info from the request 
    auth = request.authorization
    user_name = auth.username
    password = auth.password

    #make a query to database to see if the user exists or not
    result = db.engine.execute(
        'SELECT username, password FROM USERS WHERE USERS.username = \'{}\' AND USERS.password = \'{}\''.format(user_name, password)).first()

    #send a response
    if result is None:
        return {"error": "Unauthorized"}, 401
    else:
        return {
            "token": "super_secret_token"
        }


'''
The browse_recipe method is for /Browse route which only accepts 'GET' requests
It gets all the recipes based on the mealtype selected by the user. If no
melatype is selected then it returns all the recipes

INPUT:
    Get the meal type from the request

OUTPUT:
    Return recipes based on the mealtype selected
    If there is no meal type then return all recipes 
'''
@app.route("/Browse", methods=['GET'])
def browse_recipe():
    #get all the mealtypes from request
    param1 = request.args.get('param1')
    param2 = request.args.get('param2')
    param3 = request.args.get('param3')
    param4 = request.args.get('param4')

    # if no mealtype given then return all recipes 
    if param1 is None and param2 is None and param3 is None and param4 is None:
        #query to the database for all recpes
        result = db.engine.execute(
         '''SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, R.created_date, R.created_user_id,R.meal_id, RA.rating, M.type_name
            FROM RECIPE R, RATING RA,MEAL_TYPE M WHERE R.recipe_id=RA.recipe_id AND R.meal_id=M.meal_id''').all()
        if result is None:
            return {"error": "unsuccessful query"}, 401
        else:
            return {'result': [dict(row) for row in result]}
    else: # Add recipes based on the mealtype selected
        result = {"result": []}
        if param1 is not None:
            recipes = get_recipes_meal_type(param1)
            for x in recipes:
                result['result'].append(x)
        if param2 is not None:
            recipes = get_recipes_meal_type(param2)
            for x in recipes:
                result['result'].append(x)
        if param3 is not None:
            recipes = get_recipes_meal_type(param3)
            for x in recipes:
                result['result'].append(x)
        if param4 is not None:
            recipes = get_recipes_meal_type(param4)
            for x in recipes:
                result['result'].append(x)
        return result, 200


'''
The method meal_planner() is for route /planner which accepts
only 'GET' requests. It takes in a cost and a mealtype. Based
on those two parameters it fetches all the recipes which are under
the cost provided and for mealtype provided. At max it will select
7 recipes.

INPUT:
    Cost (provided in request) 
    Mealtype (provided in request)

OUTPUT:
    Recipes under the cost and for provided mealtype
    In any other case returns an error message with 401
'''
@app.route("/planner", methods=['GET'])
def meal_planner():
    #get the input data from request
    cost = float(request.args.get('cost'))
    meal_type = request.args.get('mealtype')

    #if any of the parameter is not provided then send an error message
    if cost is None or meal_type is None:
        return {"error": "required paramters not provided"}, 401

    #perform a query to get all the recipes based on the parameters provided
    result = db.engine.execute(
    '''SELECT * FROM RECIPE, MEAL_TYPE, RATING
       WHERE recipe_total_cost <= {}
       AND type_name = '{}' AND RECIPE.meal_id = MEAL_TYPE.meal_id AND RECIPE.recipe_id = RATING.recipe_id
       ORDER BY recipe_total_cost
    '''.format(cost, meal_type)).all()

    #format the data in a proper way
    recipe_dict = [dict(row) for row in result]
    final_result = []
    accumulated_cost = 0
    for recipe in recipe_dict:
        if len(final_result) >= 7:
            break
        if not(accumulated_cost + recipe['recipe_total_cost'] > cost):
            final_result.append(recipe)
            accumulated_cost += recipe['recipe_total_cost']

    return jsonify({'result': final_result}), 200


'''
A helper method which takes in a mealtype and returns
all recipes with that mealtype from the database

INPUT:
    Mealtype

OUTPUT:
    All recipes with the given mealtype
'''
def get_recipes_meal_type(meal_type):
    #query the database to get all the recipes based on the mealtype provided
    query_result = db.engine.execute(
        '''
        SELECT R.recipe_id, R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, M.type_name, RA.rating
        FROM MEAL_TYPE M, RECIPE R, RATING RA
        WHERE M.type_name = '{}'
        AND R.meal_id = M.meal_id
        AND R.recipe_id = RA.recipe_id
           '''.format(meal_type)).all()
    return [dict(r) for r in query_result]


'''
The method search is for route /search which accepts 'GET' requests.
It takes an input from user and searches the database and does a pattern
matching between the user input and recipe names

INPUT:
    String

OUTPUT:
    Recipes, if it exists
    401 with not found message if does not exist
'''
@app.route("/search", methods=['GET'])
def search():
    # get the recipe name from the request
    arg = request.args.get('recipe_name')
    #query the database to find recipes which matches the user input
    query_result = db.engine.execute(
        '''
        SELECT *
        FROM RECIPE
        WHERE LOWER(recipe_title) LIKE LOWER('%%{}%%')
        '''.format(arg)).all()

    if query_result is None:
        return {"error": "unsuccessful query"}, 401
    else:
        return json.dumps([dict(r) for r in query_result]), 200

'''
browse_search() method is for /Browse_search route which accepts
the 'GET' requests. It gets the type of filter and sorts the recipes
based on the filter type selected by the user. The filter type can be ascending, descending 
or ratings.

INPUT:
    filter type (example: ascending, descending, etc)

OUTPUT:
    if succesful return the reipes sorted based on the filter selected
    else return an error message
'''
@app.route("/Browse_search", methods=['GET'])
def browse_search():
    #get the filter from the request
    req = request.json
    response = req.get("filter")
    result = []
    asc = 'ASC'
    des = 'DESC'
    #select all the information needed from the database 
    statement = "SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, R.created_date, R.created_user_id,R.meal_id, RA.rating, M.type_name FROM RECIPE R, RATING RA,MEAL_TYPE M WHERE R.recipe_id=RA.recipe_id AND R.meal_id=M.meal_id ORDER BY recipe_total_cost {}"
    #sort it based on the filter type selected by the user 
    if response == 'cost_decending_order':
        result = db.engine.execute(
            statement.format(des)).all()
    elif response == 'cost_ascending_order':
        result = db.engine.execute(
            statement.format(asc)).all()
    elif response == 'rating':
        result = db.engine.execute(
            ''' SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, R.created_date, R.created_user_id,R.meal_id, RA.rating, M.type_name
                FROM RECIPE R, RATING RA,MEAL_TYPE M WHERE R.recipe_id=RA.recipe_id AND R.meal_id=M.meal_id 
                ORDER BY RA.rating DESC,R.recipe_total_cost ASC''').all()
    #send the response
    if result is None:
        return {"error": "unsuccessful query"}, 401
    else:

        return {'result': [dict(row) for row in result]}


'''
get_recipe method is for route /get_recipe which takes 'GET' requests. 
It takes a recipe id and gets the recipe from the database and the
ingredients needed. 

INPUT:
    Recipe_id

OUTPUT:
    If recipes exists then send the recipe with ingredients
    else an error message with 401
'''
@app.route("/get_recipe", methods=['GET'])
def get_recipe():
    #get the recipe id
    recipe_id = request.args.get('id')
    #find the recipe from the database based on the recipe_id
    query_result = db.engine.execute(
        '''
        SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, 
        R.created_date, R.created_user_id, R.meal_id, M.type_name, RA.rating, RA.user_id
        FROM RECIPE R, MEAL_TYPE M, RATING RA
        WHERE R.recipe_id = {} AND R.meal_id=M.meal_id AND R.recipe_id = RA.recipe_id'''.format(recipe_id)
    ).all()
    recipes = [dict(r) for r in query_result]
    
    #get all the ingredients for the recipe
    query_result2 = db.engine.execute('''
    SELECT C.quantity, C.measurement, I.ing_name
    FROM CONSISTS_OF C, INGREDIENT I
    WHERE C.recipe_id = {} AND C.ingredient_id=I.ingredient_id
    '''.format(recipe_id)).all()
    ingredient = [dict(r) for r in query_result2]
    result = recipes + ingredient

    #send the response
    if result is None:
        return {"error": "unsuccessful query"}, 401
    else:
        return {'ingredients': ingredient, 'recipe': recipes}, 200


# Serve React App
@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve(path):
    if path != "" and os.path.exists(app.static_folder + '/' + path):
        return send_from_directory(app.static_folder, path)
    else:
        return send_from_directory(app.static_folder, 'index.html')


if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    print("Running on port "+str(port)+"...")
    app.run(debug=True, host='0.0.0.0', port=port)
