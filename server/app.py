
from operator import methodcaller
import os
from flask import Flask, request, json, jsonify, send_from_directory
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import query
from module import *
import random

# create flask instance
app = Flask(__name__, static_folder='../client/build')
# add database
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://gtbbojbdpfuvny:d763d0bf441b5a29c4fa6542b26502e7934ea733ad4bfcb02d7903bcd7affca6@ec2-3-95-130-249.compute-1.amazonaws.com:5432/d7s9m35lp1c3ph"
# create tables/intialise the database
db = SQLAlchemy(app)

# add user to the database


@app.route('/create_user', methods=['post'])
def create_user():
    req = request.json
    user_id = random.getrandbits(18)
    first_name = req.get('first_name')
    last_name = req.get('last_name')
    email = req.get('email')
    user_name = req.get('user_name')
    password = req.get('password')
    result = db.engine.execute(
        'SELECT username FROM USERS WHERE USERS.firstname = \'{}\' AND USERS.username = \'{}\' '.format(first_name, user_name)).first()
    if result is None:
        db.engine.execute(
            'INSERT INTO USERS VALUES(\'{}\',\'{}\',\'{}\',\'{}\',\'{}\',\'{}\')'.format(user_id, first_name, last_name, user_name, email, password))
        user = db.engine.execute(
            'SELECT username FROM USERS WHERE USERS.user_id = \'{}\' AND USERS.firstname = \'{}\' AND USERS.username = \'{}\' '.format(user_id, first_name, user_name)).first()
        if user is None:
            return {"user": "not added"}, 401
        else:
            return {"user_name": str(user)}
    else:
        return {"user": 'User exists'}

# check if you user exists


@app.route("/auth", methods=['GET'])
def login():

    auth = request.authorization
    user_name = auth.username
    password = auth.password
    #result = USERS.query.filter_by(username=user_name, password = password).first()
    result = db.engine.execute(
        'SELECT username, password FROM USERS WHERE USERS.username = \'{}\' AND USERS.password = \'{}\''.format(user_name, password)).first()

    if result is None:
        return {"error": "Unauthorized"}, 401
        # return "user doesn't exist"
    else:
        return {
            "token": "super_secret_token"
        }

# return all recipes


@app.route("/Browse", methods=['GET'])
def browse_recipe():
    param1 = request.args.get('param1')
    param2 = request.args.get('param2')
    param3 = request.args.get('param3')
    param4 = request.args.get('param4')

    if param1 is None and param2 is None and param3 is None and param4 is None:
        # return {"error": "unsuccessful query"}, 401
        result = db.engine.execute(
            '''SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, R.created_date, R.created_user_id,R.meal_id, RA.rating, M.type_name
            FROM RECIPE R, RATING RA,MEAL_TYPE M WHERE R.recipe_id=RA.recipe_id AND R.meal_id=M.meal_id''').all()
        if result is None:
            return {"error": "unsuccessful query"}, 401
        else:
            return {'result': [dict(row) for row in result]}
    else:
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

# get specific meal


@app.route("/planner", methods=['GET'])
def meal_planner():
    cost = float(request.args.get('cost'))
    meal_type = request.args.get('mealtype')
    if cost is None or meal_type is None:
        return {"error": "unsuccessful query"}, 401

    result = db.engine.execute(
        '''SELECT * FROM RECIPE, MEAL_TYPE
       WHERE recipe_total_cost <= {}
       AND type_name = '{}' AND RECIPE.meal_id = MEAL_TYPE.meal_id
       ORDER BY recipe_total_cost
    '''.format(cost, meal_type)).all()
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


def get_recipes_meal_type(meal_type):
    query_result = db.engine.execute(
        '''
        SELECT R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, M.type_name, RA.rating
        FROM MEAL_TYPE M, RECIPE R, RATING RA
        WHERE M.type_name = '{}'
        AND R.meal_id = M.meal_id
        AND R.recipe_id = RA.recipe_id
           '''.format(meal_type)).all()
    return [dict(r) for r in query_result]

# search through the database


@app.route("/search", methods=['GET'])
def search():
    arg = request.args.get('recipe_name')
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

# drop down selections


@app.route("/Browse_search", methods=['GET'])
def browse_search():
    req = request.json
    response = req.get("filter")
    result = []
    asc = 'ASC'
    des = 'DESC'
    statement = "SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, R.created_date, R.created_user_id,R.meal_id, RA.rating, M.type_name FROM RECIPE R, RATING RA,MEAL_TYPE M WHERE R.recipe_id=RA.recipe_id AND R.meal_id=M.meal_id ORDER BY recipe_total_cost {}"
    if response == 'cost_decending_order':
        result = db.engine.execute(
            statement.format(des)).all()
    elif response == 'cost_ascending_order':
        result = db.engine.execute(
            statement.format(asc)).all()
    elif response == 'rating':
        result = db.engine.execute(
            '''SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, R.created_date, R.created_user_id,R.meal_id, RA.rating, M.type_name
         FROM RECIPE R, RATING RA,MEAL_TYPE M WHERE R.recipe_id=RA.recipe_id AND R.meal_id=M.meal_id 
                ORDER BY RA.rating DESC,R.recipe_total_cost ASC''').all()
    if result is None:
        return {"error": "unsuccessful query"}, 401
    else:

        return {'result': [dict(row) for row in result]}

# return all recipes


@app.route("/get_recipe", methods=['GET'])
def get_recipe():
    recipe_id = request.args.get('id')
    query_result = db.engine.execute(
        '''
        SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, 
        R.created_date, R.created_user_id, R.meal_id, M.type_name, RA.rating, RA.user_id
        FROM RECIPE R, MEAL_TYPE M, RATING RA
        WHERE R.recipe_id = {} AND R.meal_id=M.meal_id AND R.recipe_id = RA.recipe_id'''.format(recipe_id)
    ).all()

    recipes = [dict(r) for r in query_result]

    query_result2 = db.engine.execute('''
    SELECT C.quantity, C.measurement, I.ing_name
    FROM CONSISTS_OF C, INGREDIENT I
    WHERE C.recipe_id = {} AND C.ingredient_id=I.ingredient_id
    '''.format(recipe_id)).all()

    ingredient = [dict(r) for r in query_result2]
    result = recipes + ingredient

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
    # meal_planner()
