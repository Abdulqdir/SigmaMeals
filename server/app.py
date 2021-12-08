
from operator import methodcaller
from flask import Flask, request, jsonify, json
import os
from flask import Flask, request, jsonify, send_from_directory
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
    user_id = random.getrandbits(12)
    first_name = req.get('first_name')
    last_name = req.get('last_name')
    email = req.get('email')
    user_name = req.get('user_name')
    password = req.get('password')
    db.engine.execute(
        'INSERT INTO USERS VALUES(\'{}\',\'{}\',\'{}\',\'{}\',\'{}\',\'{}\')'.format(user_id,first_name,last_name,email,user_name, password)).first()

    # result = USERS(user_id=user_id, first_name=first_name, last_name=last_name,
    #                email=email, user_name=user_name, password=password)
    # db.session.add(result)
    # db.session.commit()
    result = db.engine.execute(
        'SELECT username FROM USERS WHERE USERS.username = \'{}\' '.format(user_name)).first()

    if result is None:
        return jsonify({"error": "User not added"}), 401
    else:
        return {
            "token": "super_secret_token"
        }, 200

# add user to the database


@app.route("/auth", methods=['GET'])
def login():
    # req = request.json
    # user_name = req.get('username')
    # password = req.get('password')
    # auth = request.headers.get('Authorization')
    auth = request.authorization
    # print(request.authorization)
    # print(base64.b64decode(auth))
    # auth = auth.split(" ")
    # user_name = auth[1].split(":")[0]
    user_name = auth.username
    # password = auth[1].split(":")[1]
    password = auth.password
    print(user_name, password)

    #result = USERS.query.filter_by(username=user_name, password = password).first()
    result = db.engine.execute(
        'SELECT username, password FROM USERS WHERE USERS.username = \'{}\' AND USERS.password = \'{}\''.format(user_name, password)).first()

    if result is None:
        return jsonify({"error": "Unauthorized"}), 401
        # return "user doesn't exist"
    else:
        return {
            "token": "super_secret_token"
        }, 200

# add user to the database


@app.route("/Browse", methods=['GET'])
def browse_recipe():

    result = db.engine.execute(
        'SELECT * FROM RECIPE').all()

    if result is None:
        return jsonify({"error": "unsuccessful query"}), 401
    else:
        recipe_dict = {}
        for i in  result:
            rec_dic = dict(i)
            recipe_dict[rec_dic['recipe_id']] = rec_dic
        return recipe_dict, 200



@app.route("/mealtype", methods=['GET'])
def meal_type_filter():
    param1 = request.args.get('param1')
    param2 = request.args.get('param2')
    param3 = request.args.get('param3')
    param4 = request.args.get('param4')

    if param1 is None and param2 is None and param3 is None and param4 is None:
        return jsonify({"error": "unsuccessful query"}), 401

    result = ""
    if param1 is not None: result += get_recipes_meal_type(param1)
    if param2 is not None: result += get_recipes_meal_type(param2)
    if param3 is not None: result += get_recipes_meal_type(param3)
    if param4 is not None: result += get_recipes_meal_type(param4)
    return result, 200

    
def get_recipes_meal_type(meal_type):
    query_result = db.engine.execute(
        '''
        SELECT R.recipe_title, R.recipe_description, R.prep_time, R.recipe_total_cost, R.instructions, R.image_url, M.type_name, RA.rating
        FROM MEAL_TYPE M, RECIPE R, RATING RA
        WHERE M.type_name = '{}'
        AND R.meal_id = M.meal_id
        AND R.recipe_id = RA.recipe_id
           '''.format(meal_type)).all()
    return json.dumps([dict(r) for r in query_result])


@app.route("/search", methods=['GET'])
def search():
    arg = request.args.get('recipe_name')
    query_result = db.engine.execute(
        '''
        SELECT *
        FROM RECIPE
        WHERE LOWER(recipe_title) LIKE LOWER('%%{}%%')
        '''.format(arg)).all()
    print(query_result)

    if query_result is None:
        return jsonify({"error": "unsuccessful query"}), 401
    else:
        return json.dumps([dict(r) for r in query_result]), 200



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
    #print(jsonify(username="data",email="error",id="id"))
