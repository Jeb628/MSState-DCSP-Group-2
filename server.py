import string
import BaseHTTPServer
from SocketServer import ThreadingMixIn
import threading
import cgi
from os import curdir, sep
import _mysql_exceptions
import MySQLdb
import sys

server_host = 'localhost'
server_port = 80
global begin, end
beg = open("index.html", "r")
en = open("index2.html", "r")
begin = beg.read()
end = en.read()
beg.close()
en.close()

class Handler(BaseHTTPServer.BaseHTTPRequestHandler):

        def do_HEAD(p):

                p.send_response(200)
                p.send_header("Content-type", "text/html")
                p.end_headers()
                
        def do_GET(p):
                global begin, end

                if p.path.startswith("/foot.aspx?"):

                    try:
                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin+end)
                    except IOError:
                        p.send_error(404, 'File Not Found')

                elif p.path.startswith("/bask.aspx?"):

                    try:
                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin+end)

                    except IOError:
                        p.send_error(404, 'File Not Found')

                elif p.path.startswith("/base.aspx?"):

                    try:
                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin+end)

                    except IOError:
                        p.send_error(404, 'File Not Found')

                else:

                    try:
                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin+end)

                    except IOError:
                        p.send_error(404, 'File Not Found')

        def do_POST(p):  # Handles POST requests
                global begin, end


                if p.headers.dict.has_key('content-length'):
                    length = string.atoi(p.headers.dict["content-length"])
                    posts = p.rfile.read(length)
                    print posts

                if p.path.startswith("/login.aspx?"):

                    try:

                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin+end)

                    except IOError:
                        p.send_error(404, 'File Not Found')

                elif p.path.startswith("/logout.aspx?"):

                    try:

                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin+end)

                    except IOError:
                        p.send_error(404, 'File Not Found')

                elif p.path.startswith("/base.aspx?"):

                    try:

                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin+end)

                    except IOError:
                        p.send_error(404,'File Not Found')

                else:

                    try:

                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin+end)

                    except IOError:
                        p.send_error(404, 'File Not Found')

        def dtb(query):  # Data Table Build
            build = ''

            for row in query:

                build += '['
                for column in row:
                    build = build + "'" + column + "',"
                build[build.length()-1] = ']'
                build += ','
            build[build.length()-1] = ''

            return build

        def hndlQuery(self):  # Handles Query processing

            queryArray = 0

            return queryArray

class ThreadedHTTPServer(ThreadingMixIn, BaseHTTPServer.HTTPServer):
        """Handle Requests in Threads"""

httpd = ThreadedHTTPServer((server_host, server_port), Handler)

try:

    print "Server up"
    httpd.serve_forever()
        
except KeyboardInterrupt:
        pass

httpd.server_close()
