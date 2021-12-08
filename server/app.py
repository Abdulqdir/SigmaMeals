
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
            'INSERT INTO USERS VALUES(\'{}\',\'{}\',\'{}\',\'{}\',\'{}\',\'{}\')'.format(user_id, first_name, last_name, user_name, email, password))
        user = db.engine.execute(
            'SELECT username FROM USERS WHERE USERS.user_id = \'{}\' AND USERS.firstname = \'{}\' AND USERS.username = \'{}\' '.format(user_id, first_name, user_name)).first()
        if user is None:
            return {"user": "not added"}
        else:
            return {"user_name": str(user)}
    else:
        return {"user": 'User exists'}

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

    #result = USER.query.filter_by(username=user_name, password = password).first()
    result = db.engine.execute(
        'SELECT username, password FROM USERS WHERE USERS.username = \'{}\' AND USERS.password = \'{}\''.format(user_name, password)).first()

    if result is None:
        return {"error": "Unauthorized"}, 401
        # return "user doesn't exist"
    else:
        return {
            "token": "super_secret_token"
        }

# add user to the database


@app.route("/Browse", methods=['GET'])
def browse_recipe():

    result = db.engine.execute(
        'SELECT * FROM RECIPE').all()

    if result is None:
        return {"error": "unsuccessful query"}, 401
    else:
        return jsonify({'result': [dict(row) for row in result]})


# Serve React App
@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve(path):
    if path != "" and os.path.exists(app.static_folder + '/' + path):
        return send_from_directory(app.static_folder, path)
    else:
        return send_from_directory(app.static_folder, 'index.html')


if __name__ == '__main__':
<<<<<<< HEAD
    app.run(debug=True)
    result = db.engine.execute(
        'SELECT * FROM RECIPE').all()
    string = ""
    for i in result:
        string = string + str(dict(i))
    print(string)
=======
    port = int(os.environ.get("PORT", 5000))
    print("Running on port "+str(port)+"...")
    app.run(debug=True, host='0.0.0.0', port=port)
    #print(jsonify(username="data",email="error",id="id"))
>>>>>>> origin/master
