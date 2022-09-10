from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from config import config

application = Flask(__name__)
application.config["SQLALCHEMY_DATABASE_URI"] = config["DATABASE_URI"]
application.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = config[
    "TRACK_MODIFICATIONS"
]

db = SQLAlchemy(application)
CORS(application)
