
import os
from flask import Flask, request, jsonify, send_from_directory
from flask_sqlalchemy import SQLAlchemy
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
        'INSERT INTO USERS VALUES(\'{}\',\'{}\',\'{}\',\'{}\',\'{}\',\'{}\')'.format(user_id,first_name,last_name,user_name,email, password))
        user = db.engine.execute(
        'SELECT username FROM USERS WHERE USERS.user_id = \'{}\' AND USERS.firstname = \'{}\' AND USERS.username = \'{}\' '.format(user_id, first_name,user_name)).first()
        if user is None:
            return {"user": "not added"},401
        else:
            return {"user_name":str(user)} 
    else:
        return {"user" :'User exists'}

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

    result = db.engine.execute(
        '''SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, R.created_date, R.created_user_id,R.meal_id, RA.rating, M.type_name
         FROM RECIPE R, RATING RA,MEAL_TYPE M WHERE R.recipe_id=RA.recipe_id AND R.meal_id=M.meal_id''').all()

    if result is None:
        return {"error": "unsuccessful query"},401
    else:
        return {'result': [dict(row) for row in result]}
# drop down selections
@app.route("/Browse_search", methods=['GET'])
def browse_search():
    req = request.json
    response = req.get("filter")
    result = []
    if response == 'cost_decending_order':
        result = db.engine.execute(
             '''SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, R.created_date, R.created_user_id,R.meal_id, RA.rating, M.type_name
         FROM RECIPE R, RATING RA,MEAL_TYPE M WHERE R.recipe_id=RA.recipe_id AND R.meal_id=M.meal_id ORDER BY recipe_total_cost DESC''').all()
    elif response == 'cost_ascending_order':
        result = db.engine.execute(
            '''SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, R.created_date, R.created_user_id,R.meal_id, RA.rating, M.type_name
         FROM RECIPE R, RATING RA,MEAL_TYPE M WHERE R.recipe_id=RA.recipe_id AND R.meal_id=M.meal_id ORDER BY recipe_total_cost ASC''').all()
    elif response == 'rating':
        result = db.engine.execute(
            '''SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, R.created_date, R.created_user_id,R.meal_id, RA.rating, M.type_name
         FROM RECIPE R, RATING RA,MEAL_TYPE M WHERE R.recipe_id=RA.recipe_id AND R.meal_id=M.meal_id 
                ORDER BY R.recipe_total_cost ASC,RA.rating DESC''').all()
    if result is None:
        return {"error": "unsuccessful query"},401
    else:
        
        return {'result': [dict(row) for row in result]}

# return all recipes
@app.route("/get_recipe", methods=['GET'])
def get_recipe():

    result = db.engine.execute(
        '''SELECT R.recipe_id,R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, 
        R.created_date, R.created_user_id,R.meal_id, M.type_name, C.quantity, C.measurement, I.ing_name, RA.rating, RA.user_id
         FROM RECIPE R, CONSISTS_OF C, INGREDIENT I,MEAL_TYPE M, RATING RA 
         WHERE R.recipe_id=C.recipe_id AND R.meal_id=M.meal_id AND C.ingredient_id=I.ingredient_id AND R.recipe_id = RA.recipe_id''').all()

    if result is None:
        return {"error": "unsuccessful query"},401
    else:
        return {'result': [dict(row) for row in result]}
# Serve React App
@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve(path):
    if path != "" and os.path.exists(app.static_folder + '/' + path):
        return send_from_directory(app.static_folder, path)
    else:
        return send_from_directory(app.static_folder, 'index.html')


if __name__ == '__main__':
    app.run(debug=True)
