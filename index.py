#!/usr/bin/env python
# -*- coding: utf-8 -*-


import os
import sqlite3
import markdown

from argon2 import PasswordHasher
import beaker.middleware

import bottle
from bottle import datetime, hook, install, get, post, redirect, request, route, run, static_file, template
from bottle_sqlite import SQLitePlugin


session_opts = {
    'session.type': 'file',
    'session.cookie_expires': 600,
    'session.data_dir': './session/',
    'session.auto': True,
}

app = beaker.middleware.SessionMiddleware(bottle.app(), session_opts)

ph = PasswordHasher()

install(SQLitePlugin(dbfile='bottle.db'))


def create_db():
    conn = sqlite3.connect('bottle.db')
    c = conn.cursor()

    c.execute("""
              CREATE TABLE blog (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              username CHAR(100),
              title CHAR(200) NOT NULL,
              content TEXT NOT NULL,
              date TEXT);
              """)

    c.execute("""
              CREATE TABLE user (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              username CHAR(100) NOT NULL,
              password CHAR(200) NOT NULL,
              email CHAR(200) NOT NULL);
              """)

    c.execute("INSERT INTO blog (title, content, date) VALUES ('Visit the Python website',"
              "'寒蟬淒切，對長亭晚，驟雨初歇。都門帳飲無緒，留戀處，蘭舟催發。"
              "執手相看淚眼，竟無語凝噎。念去去，千裏煙波，暮霭沈沈楚天闊。"
              "多情自古傷離別，更那堪，冷落清秋節！今宵酒醒何處？楊柳岸，曉風殘月。"
              "此去經年，應是良辰好景虛設。便縱有千種風情，更與何人說？', '2019-04-20 00:00:00');")

    conn.commit()
    conn.close()

    return


if not os.path.exists('bottle.db'):
    create_db()


@route('/')
@route('/posts')
def index(db):
    posts = db.execute('SELECT id, title, content, date FROM blog ORDER BY id DESC').fetchall()
    posts = [{
        "id": post['id'],
        "title": post['title'],
        "content": post['content'],
        "date": post['date']
    } for post in posts]

    for post in posts:
        x = markdown.markdown(post['content'], extensions=['extra', 'codehilite'])
        post['content'] = x

    return template('posts', posts=posts)


@route('/post/<post_id>')
def detail(db, post_id):
    post = db.execute('SELECT title, content, date FROM blog WHERE id = ?', (post_id,)).fetchone()
    title, content, date = post
    content = markdown.markdown(post['content'], extensions=['extra', 'codehilite'])

    return template('post_detail', title=title, content=content, date=date)


@get('/admin/login')
def login():
    return template('admin/login')


@post('/admin/login')
def do_login(db):
    username = request.forms.get('username')
    password = request.forms.get('password')
    if validate_login(db, username, password):
        request.session['username'] = username
        redirect('/admin/dashboard')
    else:
        return '<p>Login failed. Please try again!</p>'


# Just a convinent means to create new user - please remove this in production
@get('/admin/create-admin')
def create_admin(db):
    create_user(db, 'vivo', '123456', 'test@126.com')

    redirect('/admin/login')


@get('/admin/dashboard')
def dashboard(db):
    if 'username' not in request.session:
        redirect('/admin/login')

    posts = db.execute('SELECT id, title, content, date FROM blog ORDER BY id DESC').fetchall()
    return template('admin/dashboard', posts=posts)


@get('/admin/add-post')
def add_post():
    if 'username' not in request.session:
        redirect('/admin/login')

    return template('admin/add_post', status=None)


@post('/admin/add-post')
def add_post(db):
    if 'username' not in request.session:
        redirect('/admin/login')

    title = request.forms.getunicode('title')
    content = request.forms.getunicode('content')
    date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    username = request.session['username']
    add_post = db.execute('INSERT INTO blog (username, title, content, date) VALUES (?, ?, ?, ?)',
                          (username, title, content, date))

    # return something to indicate it has been added.
    status = None
    if add_post:
        status = 'success'

    return template('admin/add_post', status=status)


@get('/admin/post/update/<post_id>')
def index(db, post_id):
    if 'username' not in request.session:
        redirect('/admin/login')

    post = db.execute('SELECT id, title, content, date FROM blog WHERE id = ?', (post_id,)).fetchone()

    return template('admin/update_post', post=post, status=None)


@post('/admin/post/update/<post_id>')
def index(db, post_id):
    if 'username' not in request.session:
        redirect('/admin/login')

    title = request.forms.getunicode('title')
    content = request.forms.getunicode('content')
    update_post = db.execute('UPDATE blog SET title=?, content=? WHERE id=?', (title, content, post_id,))
    post = db.execute('SELECT id, title, content FROM blog WHERE id = ?', (post_id,)).fetchone()

    # return something to indicate it has been added.
    status = None
    if update_post:
        status = 'success'

    return template('admin/update_post', post=post, status=status)


@route('/admin/post/delete/<post_id>')
def index(db, post_id):
    if 'username' not in request.session:
        redirect('/admin/login')
    db.execute('DELETE FROM blog WHERE id=?', (post_id,))

    return template('admin/delete_post', post_id=post_id)


@hook('before_request')
def setup_request():
    request.session = request.environ['beaker.session']


def validate_login(db, username, password):
    row = db.execute('SELECT username, password FROM user WHERE username=?', (username,)).fetchone()

    if not row:
        return False

    try:
        if ph.verify(row[1], password):
            return True
        return False

    except ValueError:
        return False


# create admin user in the database
def create_user(db, username, password, email):
    password_hash = ph.hash(password)
    db.execute('INSERT INTO user (username, password, email) VALUES (?, ?, ?)', (username, password_hash, email))

    return True


@route('/pic/<filename>')
def server_pic(filename):
    return static_file(filename, root='./tmp')


# @route('/public/<filepath:path>')
# def public_assets(filepath):
#     return static_file(filepath, root='./public')


def main():
    run(host='0.0.0.0', port=8888, app=app, debug=True)


if __name__ == '__main__':
    main()
