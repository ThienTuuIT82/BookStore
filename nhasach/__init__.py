from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_admin import Admin
from flask_login import LoginManager
from flask_mail import Mail


app = Flask(__name__)
app.secret_key = '#%@$$#@$#@@%$%$@#@$####$##!$#!$'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:123456@localhost/nhasach?charset=utf8'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True

db = SQLAlchemy(app=app)
admin = Admin(app=app,
              name='Quản Lý Nhà Sách',
              template_mode="bootstrap4")
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USERNAME'] = 'cttbookstore@gmail.com'
app.config['MAIL_PASSWORD'] = 'wraiufgxgodnmrvt'
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False

login = LoginManager(app=app)
mail = Mail(app=app)