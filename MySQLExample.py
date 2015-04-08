import _mysql_exceptions
import MySQLdb
import sys

#connect to the MySQL server
db = MySQLdb.connect(host="localhost", user="root", db="SportiStats")

#create cursor object. cursor object are used for the execution of SQL statements
curs = db.cursor()

try:
    #execute a single SQL statement
    curse.execute("""INSERT INTO user (username, password) VALUES ('tester', '123456')"""
    
    #insert many fake users into the database
    curs.executemany("""INSERT INTO user (username, password)VALUES (%s, %s)""", [("will", "123465"),("jason", "123465"), ("zach", "123465"), ("thomas", "123465"), ("alex", "123465"), ("jacob", "123465"), ("buthole", "123465")])

    #for any statement besides select, THIS MUST BE INCLUDED, or you're just going to have a bad time
    #and will want to hit something when your database changes aren't working
    db.commit()

except _mysql_exceptions.Exception, e:
    #catches exception, and then pritns out error message
    print str(e)
    sys.exit(1)

finally:
    curs.execute("""SELECT * FROM user""")

    #gets all the query results, resutls are in a list
    rows = curs.fetchall()

    #interate and print out query result
    for row in rows:
        print row

    #prints out indiviual cells
    for row in rows:
        for column in row:
            print column

    #be kind, please rewind
    db.close()

