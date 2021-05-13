from sqlalchemy import Column, Integer, String, Boolean, Float, ForeignKey, Enum, DateTime
from sqlalchemy.orm import relationship
from nhasach import db
from flask_login import UserMixin
from enum import Enum as UserEnum
from datetime import datetime


class EnumRole(UserEnum):
    User = 1
    Employee = 2
    Manager = 3


class SaleBase(db.Model):
    __abstract__ = True

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)

    def __str__(self):
        return self.name


class User(SaleBase, UserMixin):
    __tablename__ = 'user'

    active = Column(Boolean, default=False)
    avatar = Column(String(100))
    username = Column(String(50), nullable=False)
    password = Column(String(50), nullable=False)
    email = Column(String(50), nullable=False)
    address = Column(String(50))
    phone = Column(String(50))
    cmnd = Column(String(50))
    UserRole = Column(Enum(EnumRole), default=EnumRole.User)

    def __str__(self):
        return self.name


class Category(SaleBase):
    __tablename__ = 'category'

    products = relationship('InfoBook',
                        backref='category', lazy=True)


class InfoBook(SaleBase):
    __tablename__ = 'book'

    description = Column(String(2000))
    price = Column(Float, default=0)
    author = Column(String(50), nullable=False)
    amount = Column(Integer, nullable=False)
    image = Column(String(255), default='static/images/default_book.png')
    category_id = Column(Integer,
                         ForeignKey(Category.id),
                         nullable=False)
    bill_detail = relationship('BillDetail', backref='book', lazy=True)
    import_book = relationship("ImportBookDetail", backref='book', lazy=True)


#class BaoCaoCongNo(SaleBase):
    #__tablename__ = 'bccongno'
    #book_name = Column(String(50), ForeignKey(InfoBook.name), nullable=False)
    #book_amount = Column(Integer, ForeignKey(InfoBook.amount), nullable=False)
    #date = Column(DateTime, nullable=False, default=datetime.today())


#Thông tin hóa đơn
class Bill(db.Model):
    __tablename__ = 'bill'
    bill_id = Column(Integer, primary_key=True, autoincrement=True)
    customer_id = Column(Integer, ForeignKey(User.id), nullable=False)
    date = Column(DateTime, nullable=False, default=datetime.today())
    total_price = Column(Float, nullable=False)
    paid = Column(String(50)) # Đã thanh toán, Chưa thanh toán, Đã bị hủy (do vượt quá số tiền cho phép nợ)
    # Chi tiết hóa đơn
    bill_detail = relationship('BillDetail', backref='bill', lazy=True)
    # Truy vấn đến bảng lưu thông tin nơi nhận
    shipping = relationship('OrderDetail', backref='bill', lazy=True)


# Chi tiết hóa đơn
class BillDetail(db.Model):
    bill_id = Column(Integer, ForeignKey(Bill.bill_id), primary_key=True, nullable=False)
    book_id = Column(Integer, ForeignKey(InfoBook.id), primary_key=True, nullable=False)
    quantity = Column(Integer, nullable=False)
    price = Column(Float, nullable=False)


class OrderDetail(SaleBase):
    __tablename__ = 'order_detail'
    bill_id = Column(Integer, ForeignKey(Bill.bill_id), nullable=False)
    address = Column(String(100))
    phone = Column(String(50))
    delivery = Column(String(50))


class ImportBook(db.Model):
    __tablename__ = 'import_book'
    id = Column(Integer, primary_key=True, autoincrement=True)
    date = Column(DateTime, nullable=False, default=datetime.today())
    import_book_detail = relationship('ImportBookDetail', backref='import_book', lazy=True)


class ImportBookDetail(db.Model):
    __tablename__ = 'import_book_detail'
    import_book_id = Column(Integer, ForeignKey(ImportBook.id), primary_key=True, nullable=False)
    book_id = Column(Integer, ForeignKey(InfoBook.id), primary_key=True, nullable=False)
    book_amount = Column(Integer, nullable=False)



class ManagerRule(db.Model):
    __tablename__ = 'manager_rule'
    # Đặt tên luật
    id = Column(Integer, primary_key=True, autoincrement=True)
    # Số lượng nhập tối thiểu
    min_import = Column(Integer, nullable=False)
    # Số lượng tồn tối thiểu để nhập thêm
    min_amount = Column(Integer, nullable=False)
    # Số tiền khách được quyền nợ tối đa
    max_debt = Column(Float, nullable=False)
    # Số lượng tồn tối thiểu sau khi bán
    min_amount_after = Column(Integer, nullable=False)
    # Sử dụng hay không sử dụng quy định này
    active = Column(Boolean, default=True)



if __name__ == '__main__':
    db.create_all()