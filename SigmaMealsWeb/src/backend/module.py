from .app import db
from datetime import datetime
class RECIPE(db.Model):
    recipe_id = db.Column(db.Integer, primary_key = True, nullable = False)
    recipe_title = db.Column(db.String(200), nullable = False)
    meal_id = db.Column(db.Integer,db.ForeignKey("MEAL_TYPE.meal_id", ondelete="SET NULL"), server_default = '7')
    cost = db.Column(db.Integer, nullable = False)
    prep_time = db.Column(db.String(200), nullable = False, server_default = "5 minutes")
    created_user_id = db.Column(db.Integer, db.ForeignKey("USER.user_id", ondelete="SET NULL") ,nullable = False, server_default = '0')
    recipe_description = db.Column(db.String(200), nullable = False, server_default = "No description provided")
    instructions = db.Column(db.String(200), nullable = False, server_default = "No description provided")
    image_url = db.Column(db.String(200))
    date = db.Column(db.DateTime, default = datetime.utcnow)

class User(db.Model):
    user_id = db.Column(db.Integer, primary_key = True, nullable = False)
    first_name = db.Column(db.String(200), nullable = False)
    last_name = db.Column(db.String(200), nullable = False)
    user_name = db.Column(db.String(200), db.CheckConstraint('user_name>4'),nullable = False, unique = True)
    email = db.Column(db.String(200), nullable = False, unique = True)
    password = db.Column(db.Text, db.CheckConstraint('password>8'), nullable = False, unique = True)

class CONSISTS_OF(db.Model):
    recipe_id = db.Column(db.Integer, db.ForeignKey("RECIPE.recipe_id", ondelete="CASCADE"),primary_key = True, nullable = False)
    ingredient_id = db.Column(db.Integer, db.ForeignKey("INGREDIENT.ingredient_id", ondelete="SET NULL"),nullable = False , primary_key = True)
    quantity = db.Column(db.Float, db.CheckConstraint('quantity>0'))
    measurement = db.Column(db.String(200), nullable = False)


class MEAL_TYPE(db.Model):
    meal_id = db.Column(db.Integer, primary_key = True, nullable = False)
    type_name = db.Column(db.String(200), nullable = False)


class INGREDIENT(db.Model):
    ingredient_id = db.Column(db.Integer, primary_key = True, nullable = False)
    ingredient_name = db.Column(db.String(200), nullable = False , primary_key = True)


class RATING(db.Model):
    recipe_id = db.Column(db.Integer, db.ForeignKey("RECIPE.recipe_id", ondelete="CASCADE"),primary_key = True, nullable = False)
    user_id = db.Column(db.Integer, db.ForeignKey("USER.user_id", ondelete="SET NULL"),nullable = False)
    rating = db.Column(db.Integer, db.CheckConstraint('rating>=0 and rating<=5'),server_default = '0')
