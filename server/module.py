# Do we need to specify constraints or can we just make an insertion statement
from app import db
from datetime import datetime
class RECIPE(db.Model):
    recipe_id = db.Column(db.Integer, primary_key = True, nullable = False)
    recipe_title = db.Column(db.String(200), nullable = False)
    meal_id = db.Column(db.Integer)
    cost = db.Column(db.Integer, nullable = False)
    prep_time = db.Column(db.String(200), nullable = False, server_default = "5 minutes")
    created_user_id = db.Column(db.Integer ,nullable = False, server_default = '0')
    recipe_description = db.Column(db.String(200), nullable = False, server_default = "No description provided")
    instructions = db.Column(db.String(200), nullable = False, server_default = "No description provided")
    image_url = db.Column(db.String(200))
    date = db.Column(db.DateTime, default = datetime.utcnow)

class USERS(db.Model):
    user_id = db.Column(db.Integer, primary_key = True, nullable = False)
    first_name = db.Column(db.String(200), nullable = False)
    last_name = db.Column(db.String(200), nullable = False)
    user_name = db.Column(db.String(200), nullable = False)
    email = db.Column(db.String(200), nullable = False)
    password = db.Column(db.Text, nullable = False)

class CONSISTS_OF(db.Model):
    recipe_id = db.Column(db.Integer, primary_key = True, nullable = False)
    ingredient_id = db.Column(db.Integer,nullable = False , primary_key = True)
    quantity = db.Column(db.Float)
    measurement = db.Column(db.String(200), nullable = False)


class MEAL_TYPE(db.Model):
    meal_id = db.Column(db.Integer, primary_key = True, nullable = False)
    type_name = db.Column(db.String(200), nullable = False)


class INGREDIENT(db.Model):
    ingredient_id = db.Column(db.Integer, primary_key = True, nullable = False)
    ingredient_name = db.Column(db.String(200), nullable = False , primary_key = True)


class RATING(db.Model):
    recipe_id = db.Column(db.Integer, primary_key = True, nullable = False)
    user_id = db.Column(db.Integer,nullable = False)
    rating = db.Column(db.Integer, server_default = '0')
