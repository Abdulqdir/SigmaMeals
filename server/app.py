
from flask import Flask, request, jsonify, json
import os
from flask import Flask, request, jsonify, send_from_directory
from flask_sqlalchemy import SQLAlchemy
from module import *

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
    first_name = req.get('first_name')
    last_name = req.get('last_name')
    email = req.get('email')
    user_name = req.get('user_name')
    password = req.get('password')
    db.engine.execute(
        'INSERT INTO USER VALUES(\'{}\',\'{}\',\'{}\',\'{}\',\'{}\')'.format(first_name, last_name, email, user_name, password)).first()

    # result = USER(user_id=user_id, first_name=first_name, last_name=last_name,
    #                email=email, user_name=user_name, password=password)
    # db.session.add(result)
    # db.session.commit()
    result = db.engine.execute(
        'SELECT username FROM USER WHERE USER.username = \'{}\' '.format(user_name)).first()

    if result is None:
        return jsonify({"error": "User not added"}), 200
    else:
        return {
            "token": "super_secret_token"
        }

# add user to the database


@app.route("/auth", methods=['GET'])
def login():
    # req = request.json
    # user_name = req.get('username')
    # password = req.get('password')
    auth = request.headers.get('Authorization')
    auth = auth.split(" ")
    user_name = auth[1].split(":")[0]
    password = auth[1].split(":")[1]

    #result = USER.query.filter_by(username=user_name, password = password).first()
    result = db.engine.execute(
        'SELECT username, password FROM USER WHERE USER.username = \'{}\' AND USER.password = \'{}\''.format(user_name, password)).first()

    if result is None:
        return jsonify({"error": "Unauthorized"}), 401
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
        return jsonify({"error": "unsuccessful query"}), 401
        # return "user doesn't exist"
    else:
        return jsonify(result)


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
    result = db.engine.execute(
        'SELECT * FROM RECIPE').all()
    string = ""
    for i in result:
        string = string + str(dict(i))
    print(string)
