from sqlalchemy import desc
from nhasach.models import User, InfoBook, Category, Bill, BillDetail, OrderDetail, datetime
from nhasach import db
import hashlib


def add_user(name, username, password, email):
    user = User(name=name,
                avatar='static/images/upload/avatar.png',
                username=username,
                password=str(hashlib.md5(password.strip().encode("utf-8")).hexdigest()),email=email,active=0)
    db.session.add(user)
    db.session.commit()

    return user


def check_password(username, password):
    password = str(hashlib.md5(password.strip().encode("utf-8")).hexdigest())
    user = User.query.filter(User.username == username.strip(),
                             User.password == password).first()
    return user


def check_username_used(username):
    user = User.query.filter(User.username == username.strip()).first()
    return user


def check_email_used(email):
    user = User.query.filter(User.email == email.strip()).first()
    return user


# Tìm kiếm danh sách Sách
def read_products(kw=None, id=None):
    products = InfoBook.query
    if kw:
        products = products.filter(InfoBook.name.contains(kw)).order_by(desc(InfoBook.id)).all()
    if id:
        products = products.filter(InfoBook.id == id).first()
    return products


#Tìm kiếm thông tin 1 quyển sách
def get_one_book(kw=None):
    products = InfoBook.query
    if kw:
        products = products.filter(InfoBook.name.contains(kw)).order_by(desc(InfoBook.id)).first()
    return products


def get_image_by_name(kw=None):
    image = InfoBook.query.filter(InfoBook.name.contains(kw)).first().image
    return image


def read_products_cate(kw=None):
    products = InfoBook.query
    if kw:
        products = products.filter(InfoBook.category_id.contains(kw)).order_by(desc(InfoBook.id))

    return products.all()


def read_category():
    category = Category.query
    return category.all()


def read_products_by_desc():
    products = InfoBook.query
    products = products.order_by(desc(InfoBook.id)).limit(4)

    return products.all()


def get_product_by_id(product_id):
    return InfoBook.query.get(product_id)


def read_bill():
    return Bill.query.order_by(desc(Bill.bill_id)).all()


def check_out(books, total_price, id, name, phone, address):
    bill = Bill(customer_id=id, date=datetime.now(), total_price=total_price)
    db.session.add(bill)
    for b in books:
        book = get_one_book(b[0])
        billdetail = BillDetail(bill_id=bill.bill_id,book_id=book.id, quantity=b[1], price=b[2])
        db.session.add(billdetail)
    order = OrderDetail(name=name, bill_id=bill.bill_id, address=address, phone=phone)
    db.session.add(order)
    db.session.commit()
    return True