import sqlite3


class ConnectionDB():
    def __init__(self):
        try:
            self.con = sqlite3.connect("users.db")
            self.createTable()
        except Exception as error:
            print(error)

    def createTable(self):
        # cur = self.con.cursor()
        # cur.execute("CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)")
        # self.con.commit()
        sql_create_table = """CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, email TEXT, password TEXT)"""
