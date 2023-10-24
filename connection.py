import sqlite3
import os
from dotenv import load_dotenv

load_dotenv()
ADMIN_PASS = os.getenv("ADMIN_PASS")
ADMIN_USERNAME = os.getenv("ADMIN_USERNAME")


class ConnectionDB:
    def __init__(self):
        try:
            self.con = sqlite3.connect("users.db")
            self.createTable()
        except Exception as error:
            print(error)

    def createTable(self):
        sql_create_table = """
        CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT,
        password TEXT
        )
        """
        cur = self.con.cursor()
        cur.execute(sql_create_table)
        cur.close()
        self.createAdmin()

    def createAdmin(self):
        try:
            sql_insert = """
            INSERT INTO users values(null, '{}', '{}', '{}')
            """.format(
                ADMIN_USERNAME, "davidcastagnetoa@gmail.com", ADMIN_PASS
            )  # Remeber to hide the password in .env File
            cur = self.con.cursor()
            cur.execute(sql_insert)
            self.con.commit()
        except Exception as error:
            print(f"El usuario {error} ya existe")

    def connect():
        print()


con = ConnectionDB()
