from sqlalchemy import desc
from nhasach.models import User, InfoBook, Category, Bill, BillDetail, OrderDetail, datetime, ImportBook, \
    ImportBookDetail
from nhasach import db
import hashlib


def add_book(name, description, price, author, image, amount, category):
    cate = Category.query.get(category)
    book = InfoBook(name=name, description=description, category=cate, price=price, author=author, image=image, amount=amount)
    db.session.add(book)
    db.session.commit()

    return book


def import_book(import_book_id, book_id, book_amount):
    import_book = ImportBookDetail(import_book_id=import_book_id, book_id=book_id, book_amount=book_amount)
    db.session.add(import_book)
    db.session.commit()

    return import_book


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


def filter(author=None, from_price=None, to_price=None):
    products = InfoBook.query
    if author:
        products = products.filter(InfoBook.author.contains(author))
    if from_price and to_price:
        products = products.filter(InfoBook.price.__gt__(from_price),
                                   InfoBook.price.__lt__(to_price))
    return products.all()


#Tìm kiếm thông tin 1 quyển sách bằng tên
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


def read_category_by_name(category_name=None):
    if category_name:
        category = Category.query.filter(Category.name.contains(category_name)).first()
    return category


def read_products_by_desc():
    products = InfoBook.query
    products = products.order_by(desc(InfoBook.id)).limit(4)

    return products.all()


def get_product_by_id(product_id):
    return InfoBook.query.get(product_id)


def read_bill():
    return Bill.query.order_by(desc(Bill.bill_id)).all()


def hot_books():
    bill_detail = BillDetail.query.all()
    books = {}
    for b in bill_detail:
        if b.book_id in books:
            books[b.book_id] = books[b.book_id] + int(b.quantity)
        else:
            books[b.book_id] = int(b.quantity)
    return sorted(books.items(), key=lambda kv: kv[1], reverse=True)


def confirm_bill(order_id, delivery, paid):
    order = OrderDetail.query.get(order_id)
    order.delivery = delivery
    bill = Bill.query.get(order.bill_id)
    bill.paid = paid
    db.session.commit()
    return True


def check_out(books, total_price, id, name, phone, address):
    bill = Bill(customer_id=id, date=datetime.now(), total_price=total_price)
    db.session.add(bill)
    for b in books:
        book = get_one_book(b[0])
        billdetail = BillDetail(bill_id=bill.bill_id,book_id=book.id, quantity=b[1], price=b[2])
        book.amount = book.amount - int(b[1])
        db.session.add(billdetail)
    order = OrderDetail(name=name, bill_id=bill.bill_id, address=address, phone=phone)

    db.session.add(order)
    db.session.commit()
    return order


def report_bill():
    bill = Bill.query.filter(Bill.paid == 'Chưa thanh toán').all()
    return bill


def report_book():
    book = ImportBook.query.all()
    return book


def read_import_detail_by_id(id):
    return ImportBookDetail.query.filter(ImportBookDetail.import_book_id == id).all()