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

# HTML Globals
global begin, script, title, loginWeb, tabs, search, end, index, login_failed
# Session/Login Global
global session
# Data Dump Global
global ft, bst, bkt


session = {}

b = open("begin_one.html", "r")
cript = open("script_two.html", "r")
#tit = open("title_three.html" , "r")
log = open("login_four.html", "r")
tab = open("tabs_five.html", "r")
sea = open("search_six.html", "r")
e = open("last.html", "r")

login_failed = open("login_fail.html", "r").read()
i = open("index.html", "r")
begin = b.read()
script = cript.read()
# title = tit.read()
loginWeb = log.read()
tabs = tab.read()
search = sea.read()
end = e.read()



b.close()
cript.close()
# tit.close()
log.close()
tab.close()
sea.close()
e.close()
#i.close()


def render():
    print "render"
def dtb(query):  # Data Table Build
    global session
    build = ''
    i = 0
    for row in query:
        if(row):
            build += '['
            for column in row:
                for each in column:
                    build = build + "'" + str(each).translate(None, "[](){}'") + "',"
            build = build[:-1]
            build += ']'
            build += ','
            i += 1
    build = build[:-1]
    if(build):
        return build
    else:
        return ''
def dtbp(query):  # Data Table Build
    global session
    build = ''
    for row in query:
        if(row):
            build += '['
            for column in row:
                build = build + "'" + str(column).translate(None, "[](){}'") + "',"
            build = build[:-1]
            build += ']'
            build += ','

    build = build[:-1]
    if(build):
        return build
    else:
        return ''
def query(qType, par1, par2, par3):  # Handles Query processing
    global begin, end, session
    db = MySQLdb.connect( user="root", passwd="SportiStats", host="localhost",db="sportistats")
    if(qType == 'login'):
        if(checkUser(db, par1) == 0):
            db.close()
            return 0
        else:
            db.close()
            return 1
    elif(qType == 'Search'):
        foot, base, bask = queryPlayerSearch(db, par1)
        db.close()
        return foot, base, bask
    elif(qType == 'qbp'):
        string1 = ""
        string2 = ""
        string3 = ""
        if(par1):
            sport = par1[0].lower()
            q1stat = par1[1]
            q1op = par1[2]
            q1num = par1[3]
            if(sport == "football"):
                sa = "fb"
            elif(sport == "baseball"):
                sa = "bs"
            else:
                sa = "bk"
            string1 = sport + "." + q1stat + " " + q1op + " " + q1num
        if(par2):
            q2com = par2[0]
            q2stat = par2[1]
            q2op = par2[2]
            q2num = par2[3]
            string2 = " "+q2com + " " + sport + "." + q2stat + " " + q2op + " " + q2num
        if(par3):
            q3com = par3[0]
            q3stat = par3[1]
            q3op = par3[2]
            q3num = par3[3]
            string3 = " "+q3com + " " + sport + "." + q3stat + " " + q3op + " " + q3num
        results = queryWithParts(db, sport, sa, string1, string2, string3)
        db.close()
        return results

def checkUser(db, check):
    queryString = 'SELECT * FROM user WHERE username = "' + check[0]+'"' +' AND password = MD5("' + check[1]+'")'
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
                return 0
            else:
                return 1

def queryPlayerSearch(db, playername):

    global session
    # Lists for each sport
    football = list()
    basketball = list()
    baseball = list()

    # Query for player name in each table
    baseball.append(getBaseball(db, playername))
    basketball.append(getBasketball(db, playername))
    football.append(getFootball(db, playername))

    # Generate Data Table for each result
    foot = dtb(football)
    base = dtb(baseball)
    bask = dtb(basketball)
    return foot, base, bask

def getBaseball(db, playername):
    global begin, end, session
    results = list()
    queryString = "SELECT * FROM player,baseball WHERE player.playerID = baseball.bs_playerID AND player.name = "+'"' + playername + '"'

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
    queryString = "SELECT * FROM player,basketball WHERE player.playerID = basketball.bk_playerID AND player.name = "+'"' + playername + '"'


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
    queryString = "SELECT * FROM player,football WHERE player.playerID = football.fb_playerID AND player.name = "+'"' + playername + '"'

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

def queryWithParts(db, sport, sa, s1, s2, s3):
    global begin, end, session
    results = list()

    queryString = "SELECT * from player, "+ sport + " WHERE "+ sport+"."+sa+"_playerID = player.playerID AND " + s1 + s2 + s3


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
    ret = dtbp(results)
    return ret
def pre(db,sport,sa):
    results = list()
    queryString = "SELECT * from player, "+ sport + " WHERE "+ sport+"."+sa+"_playerID = player.playerID"

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
    ret = "var " + sport +" = [ "
    ret += dtbp(results)
    ret += "];"
    return ret


class Handler(BaseHTTPRequestHandler):
        def do_HEAD(p):

                p.send_response(200)
                p.send_header("Content-type", "text/html")
                p.end_headers()

        def do_GET(p):
                global begin, script, title, loginWeb, tabs, search, end,  index
                global session
                global bkt, bst, ft

                if p.path.startswith("/foot.aspx?"):
                    splitPath = p.path.split('?')
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
                global begin, script, title, loginWeb, tabs, search, end, index, login_failed
                global session
                global bkt, bst, ft

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

                elif p.path.startswith("/search.aspx?"):
                    par = str(posts['Search']).translate(None, "[](){}'")
                    search = str(posts['Submit']).translate(None, "[](){}'")
                    res = query(search, par, None, None)

                    try:

                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(index)

                    except IOError:
                        p.send_error(404,'File Not Found')
                elif p.path.startswith("/query.aspx?"):
                    par1 = list()
                    par2 = list()
                    par3 = list()
                    qtype = "qbp"
                    if('q1sport' in posts.keys()):
                        par1.append(str(posts['q1sport']).translate(None, "[](){}'"))
                    if('q1num' in posts.keys()):
                        par1.append(str(posts['q1stat']).translate(None, "[](){}'"))
                        par1.append(str(posts['q1op']).translate(None, "[](){}'"))
                        par1.append(str(posts['q1num']).translate(None, "[](){}'"))
                    else:
                        print "Need better query bro"
                    if('q2num' in posts.keys()):
                        par2.append(str(posts['q2cmp']).translate(None, "[](){}'"))
                        par2.append(str(posts['q2stat']).translate(None, "[](){}'"))
                        par2.append(str(posts['q2op']).translate(None, "[](){}'"))
                        par2.append(str(posts['q2num']).translate(None, "[](){}'"))
                    if('q3num'in posts.keys()):
                        par3.append(str(posts['q3cmp']).translate(None, "[](){}'"))
                        par3.append(str(posts['q3stat']).translate(None, "[](){}'"))
                        par3.append(str(posts['q3op']).translate(None, "[](){}'"))
                        par3.append(str(posts['q3num']).translate(None, "[](){}'"))
                    results = query(qtype, par1, par2, par3)
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

db = MySQLdb.connect( user="root", passwd="SportiStats", host="localhost",db="sportistats")
ft = pre(db, "football", "fb")
bst = pre(db, "baseball", "bs")
bkt = pre(db, "basketball", "bk")
db.close()

index = begin + ft + bst + bkt + script + loginWeb + tabs + search + end

class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
        """Handle Requests in Threads"""
# Set host ip to whatever your local IP address is to host externally
httpd = ThreadedHTTPServer(('localhost', 80), Handler)

try:

    print "Server up"
    httpd.serve_forever()

except KeyboardInterrupt:
        pass

httpd.server_close()
