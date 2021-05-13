import hashlib, os, json
from flask import render_template, request, redirect, url_for, session, jsonify
from flask_login import login_user, logout_user, login_required
from sqlalchemy import desc, func

from nhasach import app, login, mail, db, utils
from nhasach.utils import add_user, check_password, check_username_used, check_email_used
from nhasach.models import User, EnumRole, ImportBook
from flask_mail import Message
from itsdangerous import URLSafeTimedSerializer, SignatureExpired
from nhasach.admin import *

randomToken = URLSafeTimedSerializer('key_bi_mat')


@app.route('/', methods=["post", "GET"])
def index():
    kw = request.form.get("kw")

    products = utils.read_products(kw=kw)
    new_books = utils.read_products_by_desc()
    # <-- Lọc những sách được mua nhiều nhất -->
    hb = utils.hot_books()
    hot_books = []
    i = 0
    for k, v in hb:
        if i < 4:
            i = i + 1
            hot_books.append(utils.get_product_by_id(k))
    # <--------------------------------------->
    books = []
    for x in range(1, 5):
        books.append(utils.get_product_by_id(x))
    if kw:
        if products[0].category_id == 1:
            return render_template('manga.html', manga=products)
        if products[0].category_id == 2:
            return render_template('novel.html', novel=products)
        if products[0].category_id == 3:
            return render_template('detective.html', detective=products)
    else:
        return render_template('index.html', books=books, new_products=new_books, hot_books=hot_books)


# @app.route('/products')
# def product_list():
#    cate_id = request.args.get('category_id')
#    kw = request.args.get('kw')
#    from_price = request.args.get('from_price')
#    to_price = request.args.get('to_price')
#    products = utils.read_products(cate_id=cate_id, kw=kw, from_price=from_price, to_price=to_price)

#    return render_template('product-list.html',
#                          products=products)


# @app.route('/products/<int:product_id>')
# def product_detail(product_id):
#    product = utils.get_product_by_id(product_id=product_id)
#    return render_template('product-detail.html',
#                           product=product)


@app.route("/login-admin", methods=["post", "GET"])
def login_admin():
    err_msg = ""
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password", "")
        password = str(hashlib.md5(password.strip().encode("utf-8")).hexdigest())
        user = User.query.filter(User.username == username.strip(),
                                 User.password == password,
                                 User.UserRole != EnumRole.User).first()
        if user:
            login_user(user=user)
            return redirect('admin')
        else:
            err_msg = "Mật khẩu không chính xác hoặc bạn không có quyền vào trang này"
    return render_template('admin/login.html', err_msg=err_msg)


@login.user_loader
def load_user(user_id):
    return User.query.get(user_id)


@app.route('/about')
def about():
    return render_template('about.html')


@app.route('/faqs')
def faqs():
    return render_template('faqs.html')


@app.route('/services')
def services():
    return render_template('services.html')


@app.route('/privacy')
def privacy():
    return render_template('privacy.html')


@app.route('/checkout', methods=['post'])
def checkout():
    if current_user.is_authenticated:
        if request.method == "POST":
            itemlength = int(request.form.get("itemlength"))
            if itemlength:
                books = []
                total = 0
                for idx in range(1, itemlength + 1):
                    book = [request.form.get("name_{}".format(idx)), request.form.get("quantity_{}".format(idx)),
                            int(request.form.get("price_{}".format(idx))),
                            utils.get_image_by_name(request.form.get("name_{}".format(idx)))]
                    total = total + int(request.form.get("price_{}".format(idx)))
                    books.append(book)
                session['checkout'] = books
                session['total_price'] = total
        return render_template('checkout.html', books=books, total=total)
    else:
        return redirect('login')


@app.route('/mail')
def mails():
    return render_template('mail.html')


@app.route('/login', methods=["get", "post"])
def login_usr():
    suc_msg = ""
    err_msg = ""
    if request.method == "POST":
        confirm = request.form.get("confirm")
        email = request.form.get("email")
        if confirm and email:
            err_msg = ""
            if request.method == "POST":
                name = request.form.get("name")
                username = request.form.get("username")
                password = request.form.get("password", "")
                if check_username_used(username=username):
                    err_msg = "Tài khoản này đã có người sử dụng"
                else:
                    if check_email_used(email=email):
                        err_msg = "Email này đã được sử dụng"
                    else:
                        if (len(password) > 7) and (len(password) < 17):
                            if password.strip() != confirm.strip():
                                err_msg = "Mật khẩu không khớp"
                            else:
                                if add_user(name=name, username=username, password=password, email=email):
                                    token = randomToken.dumps(email, salt="email_confirm")
                                    msg = Message('Thư xác nhận mail', sender='cttbookstore@gmail.com',
                                                  recipients=[email])
                                    link = url_for('confirm_email', token=token, username=username, _external=True)
                                    msg.body = 'Để kích hoạt tài khoản vui lòng nhấn vào liên kết sau: {}'.format(link)
                                    mail.send(msg)
                                    suc_msg = "Thư kích hoạt đã được gửi vào mail {}".format(email)
                                else:
                                    err_msg = "Hệ thống bị lỗi vui lòng đăng ký sau"
                        else:
                            err_msg = "Mật khẩu của bạn phải từ 8-16 ký tự"
        else:
            username = request.form.get("username")
            password = request.form.get("password", "")
            user = check_password(username=username, password=password)
            if user:
                if user.active == 1:
                    login_user(user=user)
                    return redirect('/')
                else:
                    err_msg = "Tài khoản này chưa được xác thực"
            else:
                err_msg = "Bạn đã nhập sai mật khẩu"

    return render_template('login.html', err_msg=err_msg, suc_msg=suc_msg)


@app.route('/confirm_email/<token>?username=<username>')
def confirm_email(token, username):
    try:
        email = randomToken.loads(token, salt='email_confirm', max_age=900)
    except SignatureExpired:
        return redirect('about')
    user = User.query.filter(User.username == username.strip()).first()
    if user:
        user.active = 1
        db.session.commit()
    return render_template('mail-success.html')


@app.route("/forgot_password", methods=['GET', 'POST'])
def forgot_password():
    suc_msg = ""
    err_msg = ""
    if request.method == 'POST':
        email = request.form.get("email")
        if check_email_used(email=email):
            token = randomToken.dumps(email, salt="reset_password")
            msg = Message('Đặt lại mật khẩu', sender='cttbookstore@gmail.com', recipients=[email])
            link = url_for('reset_password', token=token, email=email, _external=True)
            msg.body = 'Bạn đang tiến hành đặt lại mật khẩu, liên kết sẽ hết hạn sau 15 phút. ' \
                       'Nhấn vào liên kết sau để đặt lại mật khẩu: {}'.format(link)
            mail.send(msg)
            suc_msg = "Thư yêu cầu đặt lại mật khẩu đã được gửi vào mail {}".format(email)
        else:
            err_msg = "Email này không tốn tại trên hệ thống"

    return render_template("forgot-password.html", err_msg=err_msg, suc_msg=suc_msg)


@app.route('/reset_password/<token>/<email>', methods=['GET', 'POST'])
def reset_password(token, email):
    err_msg = ""
    try:
        e = randomToken.loads(token, salt='reset_password', max_age=3600)
    except SignatureExpired:
        return render_template('verify-expired.html')
    if request.method == 'POST':
        password = request.form.get("password")
        confirm = request.form.get("confirm")
        if (len(password) > 7) and (len(password) < 17):
            if password.strip() == confirm.strip():
                user = check_email_used(email=email)
                if user:
                    user.password = str(hashlib.md5(password.strip().encode("utf-8")).hexdigest())
                    db.session.commit()
                    return render_template('reset-success.html')
                else:
                    err_msg = "Email không tồn tại"
            else:
                err_msg = "Mật khẩu không khớp!"
        else:
            err_msg = "Mật khẩu của bạn phải từ 8-16 ký tự"

    return render_template('reset-pwd.html', err_msg=err_msg)


@app.route("/change_password", methods=['GET', 'POST'])
def change_password():
    if current_user.is_authenticated:
        suc_msg = ""
        err_msg = ""
        if request.method == 'POST':
            oldpassword = request.form.get("oldpassword")
            newpassword = request.form.get("newpassword")
            confirm = request.form.get("confirm")
            user = User.query.filter(User.username == current_user.username.strip()).first()
            if user:
                if user.password == str(hashlib.md5(oldpassword.strip().encode("utf-8")).hexdigest()):
                    if oldpassword != newpassword:
                        if (len(newpassword) > 7) and (len(newpassword) < 17):
                            if newpassword.strip() == confirm.strip():
                                user.password = str(hashlib.md5(newpassword.strip().encode("utf-8")).hexdigest())
                                db.session.commit()
                                suc_msg = "Bạn đã đổi mật khẩu thành công!"
                            else:
                                err_msg = "Mật khẩu xác nhận không khớp!"
                        else:
                            err_msg = "Mật khẩu mới của bạn phải từ 8-16 ký tự"
                    else:
                        err_msg = "Mật khẩu cũ và mật khẩu mới không được giống nhau!"
                else:
                    err_msg = "Bạn đã nhập sai mật khẩu cũ!"
        return render_template("change-password.html", err_msg=err_msg, suc_msg=suc_msg)
    else:
        return redirect('login')


@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect('/')


@app.route('/profiles', methods=['GET', 'POST'])
def edit_profile():
    if current_user.is_authenticated:
        suc_msg = ""
        if request.method == 'POST':
            name = request.form.get("name")
            cmnd = request.form.get("cmnd")
            address = request.form.get("address")
            phone = request.form.get("phone")
            user = User.query.filter(User.username == current_user.username.strip()).first()
            if user:
                avatar = user.avatar
                f = request.files["avatar"]
                if f:
                    username = current_user.username
                    avt = "{}_%s".format(username) % f.filename
                    avatar_path = 'static/images/upload/%s' % avt
                    path = os.path.join(app.root_path, avatar)
                    # xóa hình cũ ở file upload
                    if avatar != 'static/images/upload/avatar.png':
                        os.remove(path)
                    # thêm hình vào file upload
                    f.save(os.path.join(app.root_path, avatar_path))
                    # chỉnh lại vị trí hình
                    user.avatar = avatar_path
                if name != user.name:
                    user.name = name
                if cmnd != user.cmnd:
                    user.cmnd = cmnd
                if address != user.address:
                    user.address = address
                if phone != user.phone:
                    user.phone = phone
                db.session.commit()
                suc_msg = "Bạn đã lưu thông tin thành công!"
        return render_template('profile.html', suc_msg=suc_msg)
    return redirect('login')


@app.route('/payment', methods=['post', 'get'])
def payment():
    suc_msg = ''
    err_msg = ''
    order_id = request.form.get('order_id')
    delivery = request.form.get('delivery')
    books = session['checkout']
    total_price = session['total_price']
    #Lưu thông tin vào cơ sở dữ liệu
    if delivery and order_id:
        paid = ""
        if delivery == 'cod':
            if total_price <= ManagerRule.query.get(1).max_debt: # nợ tối đa
                err = "0"
                for b in books:
                    if err == "0":
                        book = utils.get_one_book(b[0])
                        if book.amount - int(b[1]) <= ManagerRule.query.get(1).min_amount_after: # Kiểm tra hàng tồn có trên số lượng tối thiểu cho phép
                            err = "1"
                    else:
                        break
                if err == "0":
                    paid = "Chưa thanh toán" # Đơn hoàn tất nhưng nợ đến khi nhận hàng mới thu được
                else:
                    paid = "Đã bị hủy (hết hàng)"
                    err_msg = 'Số sách bạn muốn mua hiện đang hết hàng! Vui lòng mua lại sau'
            else:
                paid = "Đã bị hủy (nợ nhiều)"
                err_msg = 'Số tiền nợ của bạn đã vượt quá 20.000VND'
        else:
            paid = "Đã thanh toán"
        bill = utils.confirm_bill(order_id, delivery, paid)
        if err_msg == "": # Kiểm tra nếu không có lỗi thì xuất thành công
            suc_msg = 'Đơn hàng của bạn đã được tiếp nhận'
        return render_template('payment.html', suc_msg=suc_msg, err_msg=err_msg)
    else:
        #Tiếp nhận thông tin
        name = request.form.get('name')
        phone = request.form.get('phone')
        address = request.form.get('address')
        order = utils.check_out(books, total_price, current_user.id, name, phone, address)
        return render_template('payment.html', order_id=order.id)


@app.route('/manga')
def manga():
    manga = utils.read_products_cate(1)
    return render_template('manga.html', manga=manga)


@app.route('/novel')
def novel():
    novel = utils.read_products_cate(2)
    return render_template('novel.html', novel=novel)


@app.route('/detective')
def detective():
    detective = utils.read_products_cate(3)
    return render_template('detective.html', detective=detective)


@app.route('/filter-form', methods=['get', 'post'])
def filter():
    author = request.form.get('author')
    from_price = request.form.get('from_price')
    to_price = request.form.get('to_price')
    products = utils.filter(author=author, from_price=from_price, to_price=to_price)
    return render_template('filter-form.html', products=products)


@app.route('/books')
def books():
    bill = utils.read_bill()
    manga = utils.read_products_cate(1)
    novel = utils.read_products_cate(2)
    detective = utils.read_products_cate(3)
    theloai = utils.read_category()
    return render_template('books.html', manga=manga, novel=novel, detective=detective, theloai=theloai)


@app.route("/single")
@app.route("/single/bookid=<book_id>")
def book_detail(book_id=None):
    if book_id:
        book = InfoBook.query.filter(InfoBook.id == book_id).first()
    else:
        book = InfoBook.query.order_by(desc(InfoBook.id)).limit(1).first()
    print(book_id)
    return render_template('single.html', book=book)


@app.route('/admin/importbook', methods=['get', 'post'])
def import_book():
    if 'message' not in session:
        session['message'] = ''
    if request.method == 'POST':
        confirm = request.args.get('confirm')
        new = request.args.get('new')
        if confirm == 'False':
            if 'import_book' not in session:
                session['import_book'] = {}

            import_book = session['import_book']
            name = request.form.get('name')
            amount = request.form.get('amount')
            print(new)
            if new == 'False':
                if int(amount) > ManagerRule.query.get(1).min_import - 1:  # Số sách tối thiểu khi thêm phải hơn 150
                    book = utils.get_one_book(kw=name)
                    if book:  # add book
                        if book.amount < ManagerRule.query.get(1).min_amount:  # Số sách tồn ít hơn 300 mới được thêm
                            import_book[str(book.id)] = {
                                'id': book.id,
                                'name': book.name,
                                'description': book.description,
                                'price': float(book.price),
                                'author': book.author,
                                'amount': int(amount),
                                'image': book.image,
                                'category_id': int(book.category_id)
                            }
                            session['import_book'] = import_book
                            session['message'] = "Bạn đã thêm {} với số lượng %s".format(book.name) % int(amount)
                        else:
                            session['message'] = "Số sách tồn phải ít hơn 300 mới được thêm"
                    else:  #
                        session['message'] = "Tên sách bạn cần thêm không tồn tại"
                else:
                    session['message'] = "Số lương sách tối thiểu khi thêm phải trên 150"
            else:
                if int(amount) > ManagerRule.query.get(1).min_import - 1:  # Số sách tối thiểu khi thêm phải hơn 150
                    book = utils.get_one_book(kw=name)
                    if not book:  # add book
                        price = request.form.get('price')
                        image = request.form.get('image')
                        author = request.form.get('author')
                        category = request.form.get('category')
                        description = request.form.get('description')
                        cate = utils.read_category_by_name(category)
                        if cate:
                            latest_id = db.session.query(func.max(InfoBook.id)).first()
                            id = str(latest_id[0] + 1)
                            import_book[id] = {
                                'id': id,
                                'name': name,
                                'description': description,
                                'price': float(price),
                                'author': author,
                                'amount': int(amount),
                                'image': image,
                                'category_id': cate.id
                            }
                            session['import_book'] = import_book
                            session['message'] = "Bạn đã thêm {} với số lượng %s".format(name) % int(amount)
                        else:
                            session['message'] = "Không tìm thấy thể loại sách này! Vui lòng thêm thể loại sách vào CSDL"
                    else:  #
                        session['message'] = "Tên sách bạn cần thêm đã có trong CSDL không thể thêm mới"
                else:
                    session['message'] = "Số lương sách tối thiểu khi thêm phải trên 150"
        else:
            import_book = ImportBook()
            db.session.add(import_book)
            db.session.commit()
            for b in session['import_book'].values():
                book = utils.get_one_book(kw=b['name'])
                if book:  # add book
                    ib = utils.import_book(import_book.id, book.id, int(b['amount']))
                    book.amount = int(b['amount']) + book.amount
                    db.session.commit()
                else:
                    utils.add_book(b['name'], b['description'], float(b['price']), b['author'], b['image'], int(b['amount']), int(b['category_id']))
                    ib = utils.import_book(import_book.id, b['id'], int(b['amount']))
            session['message'] = "Bạn đã thêm sách thành công"
            session['import_book'] = {}
    else:
        if 'message' in session:
            session['message'] = ''
    return redirect(url_for('importbook.index'))


@app.route('/admin/delbook', methods=['post'])
def del_book_in_session():
    if 'import_book' not in session:
        session['import_book'] = {}
    import_book = session['import_book']

    data = json.loads(request.data)
    id = str(data.get("id"))

    if id in import_book:
        import_book.pop(id)

    session['import_book'] = import_book
    if not import_book:
        del session['import_book']
    return jsonify({

    })


if __name__ == '__main__':
    app.run(debug=True, port='9999')
