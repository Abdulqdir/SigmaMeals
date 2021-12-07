
from flask import Flask, request, jsonify,json
from flask_sqlalchemy import SQLAlchemy
from module import *

# create flask instance
app = Flask(__name__)
# add database
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://gtbbojbdpfuvny:d763d0bf441b5a29c4fa6542b26502e7934ea733ad4bfcb02d7903bcd7affca6@ec2-3-95-130-249.compute-1.amazonaws.com:5432/d7s9m35lp1c3ph"
# create tables/intialise the database
db = SQLAlchemy(app)

# add user to the database
@app.route("/create_user", methods = ['post'])
def create_user():
    req = request.json
    first_name = req.get('first_name')
    last_name = req.get('last_name')
    email = req.get('email')
    user_name = req.get('user_name')
    password = req.get('password')
    db.engine.execute(
        'INSERT INTO USERS VALUES(\'{}\',\'{}\',\'{}\',\'{}\',\'{}\')'.format(first_name,last_name,email,user_name, password)).first()

    # result = USERS(user_id=user_id, first_name=first_name, last_name=last_name,
    #                email=email, user_name=user_name, password=password)
    # db.session.add(result)
    # db.session.commit()
    result = db.engine.execute(
        'SELECT username FROM USERS WHERE USERS.username = \'{}\' '.format(user_name)).first()

    if result is None:
        return jsonify({"error": "User not added"}), 200
    else:
        return {
            "token": "super_secret_token"
        }

# add user to the database
@app.route("/login", methods = ['POST'])
def login():
    req = request.json
    user_name = req.get('username')
    password = req.get('password')
    result = db.engine.execute(
        'SELECT username, password FROM USERS WHERE USERS.username = \'{}\' AND USERS.password = \'{}\''.format(user_name, password)).first()

    if result is None:
        return jsonify({"error": "Unauthorized"}), 401
        # return "user doesn't exist"
    else:
        return {
            "token": "super_secret_token"
        }

# add user to the database
@app.route("/Browse", methods = ['GET'])
def browse_recipe():
    
    result = db.engine.execute(
        'SELECT * FROM RECIPE').all()

    if result is None:
        return jsonify({"error": "unsuccessful query"}), 401
        # return "user doesn't exist"
    else:
        return jsonify(result)


if __name__ == '__main__':
    #app.run(debug=True)
    result = db.engine.execute(
        'SELECT * FROM RECIPE').all()
    string = ""
    for i in  result:
        string = string + str(dict(i))
    print(string)
