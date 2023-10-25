import sqlite3
import os
from dotenv import load_dotenv

# Aqui adjunta tus credenciales de administrador
load_dotenv()

ADMIN_USERNAME = os.getenv("ADMIN_USERNAME")
ADMIN_EMAIL = os.getenv("ADMIN_EMAIL")
ADMIN_PASS = os.getenv("ADMIN_PASS")


class ConnectionDB:
    def __init__(self):
        try:
            self.con = sqlite3.connect("users.db")
        except Exception as error:
            print(error)

    def init_db(self):  # Nuevo método para inicializar la base de datos
        self.createTable()

    # Crea la tabla de la DB si no existe
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
        # self.createAdmin() Crea el usuario adminnistrador

    # Crea el usuario administrador si ya existe lanza excepcion
    def createAdmin(self):
        try:
            sql_insert = """
            INSERT INTO users values(null, ?, ?, ?)
            """.format(
                ADMIN_USERNAME, ADMIN_EMAIL, ADMIN_PASS
            )  # Remeber to hide your admin data in .env File
            cur = self.con.cursor()
            cur.execute(sql_insert)
            self.con.commit()
            print("Usuario creado")
            cur.close()
        except Exception as error:
            print(f"El usuario {error} ya existe")

    def connect(self):
        return self.con
