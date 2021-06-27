
from flask import Flask, render_template, request, json, redirect, jsonify
from flaskext.mysql import MySQL
from flask import session
from werkzeug.utils import secure_filename
from flask_bcrypt import Bcrypt
from flask_paginate import Pagination, get_page_parameter
from datetime import datetime

app = Flask(__name__)
bcrypt = Bcrypt(app)
mysql = MySQL()

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'root'
app.config['MYSQL_DATABASE_DB'] = 'movie_theater'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
app.config['MYSQL_DATABASE_PORT'] = 8889
mysql.init_app(app)


app.secret_key = 'secret key can be anything!'


@app.route("/")
def main():
    return render_template('index.html')

@app.route('/showSignUp')
def showSignUp():
    return render_template('signup.html')

@app.route('/userHome')
def userHome():
    if session.get('user'):
        conn = mysql.connect()
        cursor = conn.cursor()
        
        cursor.execute("SELECT * FROM user as u WHERE u.userid=%s", session['user'])
        data = cursor.fetchall()
        conn.commit()
        if data[0][4] == 1:
            return redirect('/showAdmin')
        else:
            query="SELECT mo.orderID, mo.OrderDate, mo.Total_price, m.title, mo.number, m.price, m.image, m.description FROM movie_order AS mo JOIN \
                   movie as m on mo.movieid=m.movieid WHERE mo.UserID=%s"
            cursor.execute(query,(session['user']))
            history=cursor.fetchall()
            conn.commit()
                
            return render_template('user.html', history=history)
    else:
        return render_template('error.html',error = 'Unauthorized Access')

@app.route('/delete/<int:task_id>')
def delete(task_id):
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM movie WHERE movieid=%s ", task_id)
    data = cursor.fetchall()
    conn.commit()

    return redirect('/userHome')

@app.route('/edit/<int:task_id>', methods = ['GET', 'POST'])
def edit(task_id):
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM movie as m WHERE m.movieid=%s", task_id)
    data = cursor.fetchall()
    
    if request.method =='POST':
        _title = request.form['title']
        _description = request.form['description']
        _price = request.form['price']
        _ticket = request.form['storeNum']
        _img = request.form['image']
        cursor.execute("UPDATE movie SET title=%s, description=%s, price=%s, ticket=%s, image=%s WHERE movieid=%s", (_title, _description, _price, _ticket, _img, task_id))
        try:
            conn.commit()
            return redirect('/userHome')
        except Exception as e:
            return render_template('error.html',error = str(e))
    else:
        return render_template('edit.html', data = data)
@app.route('/logout')
def logout():
    session.pop('user',None)
    return redirect('/')

@app.route('/showAddItem')
def showAddItem():
    return render_template('additem.html')
@app.route('/showAdmin')
def showAdmin():
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM movie")
    data = cursor.fetchall()
    return render_template("admin.html", data=data)

@app.route('/validateLogin', methods=['POST'])
def validateLogin():
    try:
        _email = request.form['inputEmail']
        _password = request.form['inputPassword']

        con = mysql.connect()
        cursor = con.cursor()
        

        cursor.execute("SELECT * FROM user WHERE email = %s", (_email))

        data = cursor.fetchall()


        if len(data) > 0:
            if bcrypt.check_password_hash(data[0][3], _password) == True:
                session['user'] = data[0][0]
                return redirect('/userHome')
            else:
                return render_template('error.html',error = 'Wrong Email address or Password.')
        else:
            return render_template('error.html',error = 'Wrong Email address or Password.')


    except Exception as e:
        return render_template('error.html',error = str(e))
    finally:
        cursor.close()
        con.close()

    
@app.route('/signUp',methods=['POST'])
def signUp():
 
    # read the posted values from the UI
    _name = request.form['inputName']
    _email = request.form['inputEmail']
    _password = request.form['inputPassword']
    _phone = request.form['phone']
    pw_hash = bcrypt.generate_password_hash(_password)
 
    # validate the received values
    if _name and _email and _password:
        if len(_phone)==0:
            conn = mysql.connect()
            cursor = conn.cursor()

            cursor.execute("INSERT INTO user(username, email, password) VALUES (%s, %s, %s)", (_name, _email, pw_hash))
        

            data = cursor.fetchall()

            if len(data) == 0:
                conn.commit()
                return redirect('/')
            else:
                return json.dumps({'error':str(data[0])})
        else:
            conn = mysql.connect()
            cursor = conn.cursor()

            cursor.execute("INSERT INTO user(username, email, password, phone) VALUES (%s, %s, %s, %s)", (_name, _email, pw_hash, _phone))
            data = cursor.fetchall()
            if len(data) == 0:
                conn.commit()
                return redirect('/')
            else:
                return render_template('error.html')


    else:
        return json.dumps({'html':'<span>Enter the required fields!</span>'})
    cursor.close()
    con.close()

@app.route('/addItem', methods=['POST'])
def addItem():
    _title = request.form['title']
    _description = request.form['description']
    _price = request.form['price']
    _ticket = request.form['storeNum']
    _cast = request.form['actor']
    _category = request.form['categories']
    _img = request.form['image']
    
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO movie(title, description, price, ticket, image) VALUES (%s, %s, %s, %s, %s)", (_title, _description, _price, _ticket, _img))
    
    
    conn.commit()
    cast = _cast.split(',')
    category = _category.split(',')
    for i in range(len(category)):
        cursor.execute("INSERT INTO category(name) SELECT * FROM (SELECT %s AS name) AS tmp WHERE NOT EXISTS ( SELECT c.name FROM category AS c WHERE c.name = %s)", (category[i], category[i]))
        conn.commit()
    for i in range(len(cast)):
        cursor.execute("INSERT INTO actor(name) SELECT * FROM (SELECT %s AS name) AS tmp WHERE NOT EXISTS ( SELECT a.name FROM actor AS a WHERE a.name = %s)", (cast[i], cast[i]))
        conn.commit()

    cursor.execute("SELECT MovieID FROM movie AS m WHERE m.title=%s", (_title))
    _movieid = cursor.fetchall()
    for i in range(len(cast)):
        cursor.execute("SELECT actorid FROM actor AS a WHERE a.name=%s",(cast[i]))
        acast = cursor.fetchall()
        cursor.execute("INSERT INTO movie_own_actor(movieid, actorid) VALUES(%s, %s)", (_movieid, acast))
        conn.commit()

    for i in range(len(category)):
        cursor.execute("SELECT CategoryID FROM category AS c WHERE c.name=%s",(category[i]))
        cate = cursor.fetchall()
        cursor.execute("INSERT INTO movie_own_category(movieid, categoryid) VALUES(%s, %s)", (_movieid, cate))
        conn.commit()

    conn.close()
    cursor.close()
    
    return redirect('/showAdmin')
@app.route('/allMovies', methods=['GET', 'POST'])
def allMovies():
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM category")
    category=cursor.fetchall()
    if request.method == "POST":
        searchbox = request.form['searchbox']
        query = "SELECT * FROM movie as m WHERE m.title LIKE '%{}%'".format(searchbox)
        cursor.execute(query)
        data = cursor.fetchall()
        conn.commit()
        conn.close()
        cursor.close()

        return render_template('listMovies.html', data=data, category=category)
    else:
        cursor.execute("SELECT * FROM movie")
        
        data = cursor.fetchall()
        conn.commit()
        conn.close()
        cursor.close()
        return render_template('listMovies.html', data=data, category=category)
@app.route('/addtoCart/<int:movie_id>', methods=['POST'])
def addtoCart(movie_id):
    if session.get('user'):
        conn = mysql.connect()
        cursor = conn.cursor()
        number=request.form['amount']
        cursor.execute("INSERT INTO cart_own_movie(userid, movieid, number) VALUES(%s, %s, %s)", (session['user'], movie_id, number))
        conn.commit()
    return redirect('/allMovies')
@app.route('/showCart', methods=['GET'])
def showCart():
    if session.get('user'):
        conn = mysql.connect()
        cursor = conn.cursor()
        query="SELECT * FROM (SELECT cm.movieid, m.title, cm.number, m.price, cm.userid FROM cart_own_movie as cm JOIN \
               movie as m ON cm.movieid=m.movieid) AS cm2 WHERE cm2.userid=%s"
        cursor.execute(query, (session['user']))
        conn.commit()
        data=cursor.fetchall()
        sum=0
        for i in range(len(data)):
            sum=sum+data[i][3]*data[i][2]
        return render_template('shopping_cart.html', data=data, sum=sum)
@app.route('/Cartedit/<int:movie_id>', methods=['POST', 'GET'])
def Cartedit(movie_id):
    conn = mysql.connect()
    cursor = conn.cursor()
    query="SELECT * FROM (SELECT cm.movieid, m.title, cm.number, m.price, cm.userid FROM cart_own_movie as cm JOIN \
            movie as m ON cm.movieid=m.movieid) AS cm2 WHERE cm2.movieid=%s AND cm2.userid=%s"
    cursor.execute(query, (movie_id, session['user']))
    conn.commit()
    data=cursor.fetchall()
    if request.method =='POST':
        _quantity = request.form['quantity']
        cursor.execute("UPDATE cart_own_movie SET number=%s WHERE userid=%s AND movieid=%s", (_quantity, session['user'], movie_id))
        try:
            conn.commit()
            return redirect('/showCart')
        except Exception as e:
            return render_template('error.html',error = str(e))
    else:
        return render_template('Cartedit.html', data = data)

@app.route('/Cartdelete/<int:movie_id>')
def Cartdelete(movie_id):
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM cart_own_movie WHERE movieid=%s ", movie_id)
    data = cursor.fetchall()
    conn.commit()

    return redirect('/showCart')

@app.route('/checkout', methods=['POST','GET'])
def checkout():
    if session.get('user'):
        now = datetime.now()
        formatted_date = now.strftime('%Y-%m-%D')
        conn = mysql.connect()
        cursor = conn.cursor()
        query="SELECT * FROM (SELECT cm.movieid, m.title, cm.number, m.price, cm.userid FROM cart_own_movie as cm JOIN \
               movie as m ON cm.movieid=m.movieid) AS cm2 WHERE cm2.userid=%s"
        cursor.execute(query, (session['user']))
        conn.commit()
        data=cursor.fetchall()
        sum=0
        for i in range(len(data)):
            sum=sum+data[i][3]*data[i][2]
        sum=sum*1.05
        for i in range(len(data)):
            cursor.execute("INSERT movie_order(UserID, OrderDate, Total_price, movieid, number) VALUES (%s, %s, %s, %s, %s)", (session['user'], formatted_date, sum, data[i][0], data[i][2]))
            conn.commit()
            cursor.execute("SELECT ticket FROM movie WHERE movieid=%s", data[i][0])
            conn.commit()
            store=cursor.fetchall()
            cursor.execute("UPDATE movie SET ticket=%s WHERE movieid=%s", (str(store[0][0]-data[i][2]), data[i][0]))
            conn.commit()

        cursor.execute("DELETE FROM cart_own_movie WHERE userid=%s", session['user'])
        conn.commit()
        return redirect('userHome')
    else:
        return render_template('error.html',error = str(e))

@app.route('/showCat/<int:cat_id>', methods=['GET', 'POST'])
def showCat(cat_id):
    if session.get('user'):
        conn = mysql.connect()
        cursor = conn.cursor()
        query="SELECT * FROM (SELECT m.movieid, m.title, m.price, m.image, mc.categoryid FROM movie as m JOIN \
               movie_own_category as mc ON mc.movieid=m.movieid) AS m2 WHERE m2.categoryid=%s"
        cursor.execute(query, cat_id)
        data=cursor.fetchall()
        conn.commit()
        cursor.execute("SELECT * FROM category")
        category=cursor.fetchall()
        return render_template('catlist.html', data=data, category=category)
    else:
        return render_template('error.html')


if __name__ == "__main__":
   app.run()   
