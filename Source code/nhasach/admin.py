from flask_admin.contrib.sqla import ModelView
from flask_admin import BaseView, expose
from flask_login import current_user, logout_user
from flask import redirect, session
from nhasach import admin, db, utils
from nhasach.models import Category, InfoBook, User, EnumRole, Bill, BillDetail, OrderDetail, ManagerRule, \
    ImportBookDetail


class CustomModelView(ModelView):
    list_template = 'admin/model/model_list.html'
    create_template = 'admin/model/model_create.html'
    edit_template = 'admin/model/model_edit.html'
    can_delete = True
    can_edit = True
    can_create = True
    can_export = True
    column_display_pk = True
    column_exclude_list = ['password']


class RuleModelView(ModelView):
    list_template = 'admin/model/model_list.html'
    create_template = 'admin/model/model_create.html'
    edit_template = 'admin/model/model_edit.html'
    can_delete = False
    can_edit = True
    can_create = False
    can_export = False

    def is_accessible(self):
        return current_user.is_authenticated and current_user.UserRole == EnumRole.Manager


class ImportModelView(ModelView):
    list_template = 'admin/model/model_list.html'
    edit_template = 'admin/model/model_edit.html'
    can_delete = True
    can_edit = True
    can_create = False
    can_export = True
    column_display_pk = True


class ManagerModelView(CustomModelView):
    def is_accessible(self):
        return current_user.is_authenticated and current_user.UserRole == EnumRole.Manager


class EmployeeModelView(CustomModelView):
    def is_accessible(self):
        return current_user.is_authenticated and (current_user.UserRole == EnumRole.Employee or current_user.UserRole == EnumRole.Manager)


class LogoutView(BaseView):
    @expose('/')
    def index(self):
        logout_user()
        return redirect('/admin')

    def is_accessible(self):
        return current_user.is_authenticated


class BillView(BaseView):
    @expose('/')
    def index(self):
        bill = utils.read_bill()
        return self.render('admin/bill.html', bill=bill)

    def is_accessible(self):
        return current_user.is_authenticated and (current_user.UserRole == EnumRole.Employee or current_user.UserRole == EnumRole.Manager)


class ReportView(BaseView):
    @expose('/')
    def index(self):
        bill = utils.report_bill()
        book = utils.report_book()
        return self.render('admin/report.html', bill=bill, book=book)

    def is_accessible(self):
        return current_user.is_authenticated and current_user.UserRole == EnumRole.Manager


class ImportBookView(BaseView):
    @expose('/')
    def index(self):
            return self.render('admin/importbook.html')

    def is_accessible(self):
        return current_user.is_authenticated and (current_user.UserRole == EnumRole.Employee or current_user.UserRole == EnumRole.Manager)


class ImportDetailView(BaseView):
    @expose('/')
    def index(self):
            return self.render('admin/importdetail.html')

    def is_accessible(self):
        return current_user.is_authenticated and (current_user.UserRole == EnumRole.Employee or current_user.UserRole == EnumRole.Manager)


admin.add_view(ImportBookView(name='Phiếu nhập sách', endpoint='importbook'))
admin.add_view(BillView(name='Đơn đã tiếp nhận', endpoint='billview'))
admin.add_view(ReportView(name='Báo cáo'))
admin.add_view(EmployeeModelView(Category, db.session, name='Thể loại'))
admin.add_view(EmployeeModelView(InfoBook, db.session, name='Thư mục sách'))
admin.add_view(EmployeeModelView(Bill, db.session, name='Hóa đơn'))
admin.add_view(EmployeeModelView(BillDetail, db.session, name='Chi tiết hóa đơn'))
admin.add_view(EmployeeModelView(OrderDetail, db.session, name='Thông tin giao hàng'))
admin.add_view(EmployeeModelView(ImportBookDetail, db.session, name='Chi tiết phiếu nhập'))
admin.add_view(ManagerModelView(User, db.session, name='Tài khoản'))
admin.add_view(RuleModelView(ManagerRule, db.session, name='Quy Định'))
admin.add_view(LogoutView(name='Đăng Xuất'))
