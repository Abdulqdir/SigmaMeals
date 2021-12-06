
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from module import *

#create flask instance
app = Flask(__name__)
# add database
app.config['SECRET_KEY'] = 'secret'
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://://gtbbojbdpfuvny:d763d0bf441b5a29c4fa6542b26502e7934ea733ad4bfcb02d7903bcd7affca6@ec2-3-95-130-249.compute-1.amazonaws.com:5432/d7s9m35lp1c3ph"
# create tables/intialise the database
db = SQLAlchemy(app)
#user id
user_id = 330

# add user to the database
@app.route('/add_user', methods = ['post'])
def add_user():
    req = request.json
    first_name = req.get('first_name')
    last_name = req.get('last_name')
    email = req.get('email')
    user_name = req.get('user_name')
    password = req.get('password')

    result = USERS(user_id=user_id, first_name=first_name, last_name=last_name, email = email, user_name=user_name, password = password)
    db.session.add(result)
    db.session.commit()
    return 'information was added!'

if __name__ == '__main__':
    app.debug=True
    row = db.engine.execute('SELECT recipe_title, rating FROM RECIPE FULL OUTER JOIN RATING ON RECIPE.recipe_id = RATING.recipe_id;').first()
    print(row)