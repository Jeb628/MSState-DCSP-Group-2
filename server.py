import string
from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
from SocketServer import ThreadingMixIn
import threading
import cgi
from os import curdir, sep
import _mysql_exceptions
import MySQLdb
import sys
import urlparse
from mimetypes import guess_type
import hashlib

global begin, script, title, loginWeb, tabs, search, end, session, index, login_failed
session = {}
"""
b = open("begin_one.html", "r")
cript = open("script_two.html", "r")
tit = open("title_three.html" , "r")
log = open("login_four.html", "r")
tab = open("tabs_five.html", "r")
sea = open("search_six.html", "r")
e = open("last.html", "r")
"""
login_failed = open("login_fail.html", "r").read()
i = open("index.html", "r")
"""
begin = b.read()
script = cript.read()
title = tit.read()
loginWeb = log.read()
tabs = tab.read()
search = sea.read()
end = e.read()
"""
index = i.read()
"""
b.close()
cript.close()
tit.close()
log.close()
tab.close()
sea.close()
e.close()
"""
i.close()

def dtb(query):  # Data Table Build
    global session
    build = ''

    for row in query:

        build += '['
        for column in row:
            build = build + "'" + column + "',"
        build[build.length()-1] = ']'
        build += ','
    build[build.length()-1] = ''

    return build

def query(qType, par1, par2, par3):  # Handles Query processing
    global begin, end, session
    db = MySQLdb.connect( user="root", passwd="SportiStats", host="localhost",db="sportistats")
    if(qType == 'login'):
        if(checkUser(db, par1) == 0):
            return 0
        else:
            return 1
    elif(qType == 'search'):
        queryPlayerSearch(db, par1[0])
    elif(qType == 'qbp'):
        print "QBP"

    """
    results = queryPlayerSearch("SELECT * FROM players")

    for result in results:
        print result

    queryWithParts("baseball", "homerun", ">", "2", "SELECT")
    """
def checkUser(db, check):
    queryString = 'SELECT * FROM user WHERE username = "' + check[0]+'"' +' AND password = MD5("' + check[1]+'")'
    print queryString
    curs = db.cursor()
    results = list()
    try:
        curs.execute(queryString)

    except _mysql_exceptions.Exception, e:
        print str(e)
        return str(e)
    finally:

        while True:
            result = curs.fetchone()
            if result == None:
                return 0
            else:
                return 1

def queryPlayerSearch(db, playername):
    global begin, end, session
    results = list()

   # db = MySQLdb.connect( user="root", passwd="SportiStats", host="localhost",db="sportistats")

    results.append(getBaseball(db, playername))
    results.append(getBasketball(db, playername))
    results.append(getFootball(db, playername))

    db.close()
    return results

def getBaseball(db, playername):
    global begin, end, session
    results = list()
    queryString = "SELECT * FROM player JOIN baseball ON playerID = bs_playerID WHERE name = '" + playername + "'"
    print (queryString)

    curs = db.cursor()
    try:
        curs.execute(queryString)

    except _mysql_exceptions.Exception, e:
        print str(e)
        return str(e)
    finally:

        while True:
            result = curs.fetchone()
            if result == None:
                break
            else:
                results.append(result)

    return results

def getBasketball(db, playername):
    global begin, end, session
    results = list()
    queryString = "SELECT * FROM player JOIN basketball ON playerID = bk_playerID WHERE name = '" + playername + "'"
    print (queryString)

    curs = db.cursor()
    try:
        curs.execute(queryString)

    except _mysql_exceptions.Exception, e:
        print str(e)
        sys.exit(1)
    finally:

        while True:
            result = curs.fetchone()
            if result == None:
                break
            else:
                results.append(result)

    return results

def getFootball(db, playername):
    global begin, end, session
    results = list()
    queryString = "SELECT * FROM player JOIN football ON playerID = fb_playerID WHERE name = '" + playername + "'"
    print (queryString)

    curs = db.cursor()
    try:
        curs.execute(queryString)

    except _mysql_exceptions.Exception, e:
        print str(e)
        sys.exit(1)
    finally:

        while True:
            result = curs.fetchone()
            if result == None:
                break
            else:
                results.append(result)
    return results

def queryWithParts(sport, fieldName, comparetor, value, queryType):
    global begin, end, session
    results = list()
    db = MySQLdb.connect(host="localhost", user="root",passwd = "SportiStats", db="SportiStats")

    queryString = queryType +" * FROM player JOIN "+ sport+ " ON playerID = bs_playerID WHERE "+ fieldName +" "+ comparetor +" "+ value

    print queryString

    curs = db.cursor()
    try:
        curs.execute(queryString)

    except _mysql_exceptions.Exception, e:
        print str(e)
        sys.exit(1)
    finally:
        while True:
            result = curs.fetchone()
            if result == None:
                break
            else:
                results.append(result)




        #for result in curs.fetchone():
            #print result
            #results.append(result)

   # print results

    #return queryString

class Handler(BaseHTTPRequestHandler):
        def do_HEAD(p):

                p.send_response(200)
                p.send_header("Content-type", "text/html")
                p.end_headers()

        def do_GET(p):
                global begin, script, title, loginWeb, tabs, search, end, session, index

                if p.path.startswith("/foot.aspx?"):
                    splitPath = p.path.split('?')
                    print(splitPath)
                    try:
                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(index)
                    except IOError:
                        p.send_error(404, 'File Not Found')

                elif p.path.startswith("/bask.aspx?"):

                    try:
                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(index)

                    except IOError:
                        p.send_error(404, 'File Not Found')

                elif p.path.startswith("/base.aspx?"):

                    try:
                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(index)

                    except IOError:
                        p.send_error(404, 'File Not Found')

                else:

                    try:
                        #Open the file requested and send it
                        requested = open(curdir+sep+p.path,"rb")
                        p.send_response(200)
                        #this part handles the mimetypes for you.
                        mimetype, _ = guess_type(p.path)
                        p.send_header('Content-type', mimetype)
                        p.end_headers()
                        for s in requested:
                            p.wfile.write(s)
                        """
                        p.send_response(200)
                        p.send_header('Content-type',mimetype)
                        p.end_headers()
                        requested = open(curdir+sep+p.path,"rb")
                        p.wfile.write(requested.read())
                        """
                        requested.close()

                    except IOError:
                        try:
                            p.send_response(200)
                            p.send_header("Content-type", "text/html")
                            p.end_headers()
                            p.wfile.write(index)

                        except IOError:
                            p.send_error(404, 'File Not Found')

        def do_POST(p):  # Handles POST requests
                global begin, script, title, loginWeb, tabs, search, end, session, index, login_failed

                if p.headers.dict.has_key('content-length'):
                    length = string.atoi(p.headers.dict["content-length"])
                    pr = p.rfile.read(length)
                    posts = urlparse.parse_qs(pr, 0, 0)

                if p.path.startswith("/login.aspx?"):
                    par = list()
                    name = str(posts['username']).translate(None, "[](){}'")
                    pwd = str(posts['password']).translate(None, "[](){}'")
                    par.append(name)
                    par.append(pwd)
                    try:

                        qstring = "SELECT * FROM User WHERE username = "+ name +" AND password = MD5(" + pwd + ")"
                        ret = query('login', par, None, None)
                        if(ret == 1):
                            ses = hashlib.md5(name)
                            ses = ses.hexdigest()
                            session[ses] = name
                            p.send_response(200)
                            p.send_header("Content-type", "text/html")
                            p.end_headers()
                            p.wfile.write(index)
                        else:
                            p.send_response(200)
                            p.send_header("Content-type", "text/html")
                            p.end_headers()
                            p.wfile.write(login_failed)

                    except IOError:
                        p.send_error(404, 'File Not Found')

                elif p.path.startswith("/logout.aspx?"):

                    try:

                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(index)

                    except IOError:
                        p.send_error(404, 'File Not Found')

                elif p.path.startswith("/base.aspx?"):

                    try:

                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(index)

                    except IOError:
                        p.send_error(404,'File Not Found')

                else:

                    try:

                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(index)

                    except IOError:
                        p.send_error(404, 'File Not Found')


class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
        """Handle Requests in Threads"""

httpd = ThreadedHTTPServer(('localhost', 80), Handler)

try:

    print "Server up"
    httpd.serve_forever()

except KeyboardInterrupt:
        pass

httpd.server_close()
