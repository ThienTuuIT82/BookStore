from flask_admin.contrib.sqla import ModelView
from flask_admin import BaseView, expose
from flask_login import current_user, logout_user
from flask import redirect, session
from nhasach import admin, db
from nhasach.models import Category, InfoBook, User, EnumRole, Bill, BillDetail, OrderDetail

class CustomModelView(ModelView):
    list_template = 'admin/model/model_list.html'
    create_template = 'admin/model/model_create.html'
    edit_template = 'admin/model/model_edit.html'
    can_delete = True
    can_edit = True
    can_create = True
    can_export = True
    column_exclude_list = ['password']

#View dành cho quản lý
class ManagerModelView(CustomModelView):
    def is_accessible(self):
        return current_user.is_authenticated and current_user.UserRole == EnumRole.Manager

#View dành cho nhân viên
class EmployeeModelView(CustomModelView):
    def is_accessible(self):
        return current_user.is_authenticated and (current_user.UserRole == EnumRole.Manager or current_user.UserRole == EnumRole.Manager)


class LogoutView(BaseView):
    @expose('/')
    def index(self):
        logout_user()
        return redirect('/admin')

    def is_accessible(self):
        return current_user.is_authenticated


admin.add_view(EmployeeModelView(Category, db.session, name='Thể loại'))
admin.add_view(EmployeeModelView(InfoBook, db.session, name='Sách'))
admin.add_view(EmployeeModelView(Bill, db.session, name='Hóa đơn'))
admin.add_view(EmployeeModelView(BillDetail, db.session, name='Chi tiết hóa đơn'))
admin.add_view(EmployeeModelView(OrderDetail, db.session, name='Thông tin giao hàng'))
admin.add_view(ManagerModelView(User, db.session, name='Tài khoản'))
admin.add_view(LogoutView(name='Đăng Xuất'))
