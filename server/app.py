
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from module import *

# create flask instance
app = Flask(__name__)
# add database
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://gtbbojbdpfuvny:d763d0bf441b5a29c4fa6542b26502e7934ea733ad4bfcb02d7903bcd7affca6@ec2-3-95-130-249.compute-1.amazonaws.com:5432/d7s9m35lp1c3ph"
# create tables/intialise the database
db = SQLAlchemy(app)
# user id
user_id = 330
#why do we need to methods = ["post"]
# add user to the database
@app.route('/create_user', methods = ['post'])
def create_user():
    req = request.json
    first_name = req.get('first_name')
    last_name = req.get('last_name')
    email = req.get('email')
    user_name = req.get('user_name')
    password = req.get('password')

    result = USERS(user_id=user_id, first_name=first_name, last_name=last_name,
                   email=email, user_name=user_name, password=password)
    db.session.add(result)
    db.session.commit()
    return 'information was added!'

# add user to the database
@app.route('/login', methods = ['GET'])
def login():
    req = request.json
    user_name = req.get('username')
    password = req.get('password')

    #result = USERS.query.filter_by(username=user_name, password = password).first()
    result = db.engine.execute(
        'SELECT username, password FROM USERS WHERE USERS.username = \'{}\' AND USERS.password = \'{}\''.format(user_name, password)).first()

    if result is None:
        return jsonify({"error": "Unauthorized"}), 401
        # return "user doesn't exist"
    else:
        return {
            "token": "super_secret_token"
        }


if __name__ == '__main__':
    app.run(debug=True)
    row = str(db.session.execute(
        'SELECT {}, rating FROM RECIPE FULL OUTER JOIN RATING ON RECIPE.recipe_id = RATING.recipe_id'.format("recipe_title")).first())
    result = USERS(user_id=1111, first_name='Abdulqadir', last_name="Ibrahim",
                   email="email@gmail.com", user_name="king", password="782754gh")
    print(row)
