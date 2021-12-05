from flask import Flask
from flask_sqlalchemy import SQLAlchemy

#create flask instance
app = Flask(__name__)
# add database
app.config['SQLALCHEMY_DATABASE_URI'] = "database path/url"
# create tables/intialise the database
db = SQLAlchemy(app)
if __name__ == '__main__':
    print("hello")