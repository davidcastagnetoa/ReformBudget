import sqlite3
import os
from dotenv import load_dotenv
from utils.encrypter import encriptedPassword, load_key

# Aqui adjunta tus credenciales de administrador
load_dotenv()

DEFAULT_ADMIN_USERNAME = "default_username"
DEFAULT_ADMIN_EMAIL = "default@email.com"
DEFAULT_ADMIN_PASS = "default_password"

ADMIN_USERNAME = os.getenv("ADMIN_USERNAME", DEFAULT_ADMIN_USERNAME)
ADMIN_EMAIL = os.getenv("ADMIN_EMAIL", DEFAULT_ADMIN_EMAIL)
ADMIN_PASS = os.getenv("ADMIN_PASS", DEFAULT_ADMIN_PASS)

key = load_key()
encriptAdminPass = encriptedPassword(ADMIN_PASS, key)


class ConnectionDB:
    def __init__(self):
        try:
            self.con = sqlite3.connect("users.db")
        except Exception as error:
            print(error)

    def init_db(self):  # Nuevo método para inicializar la base de datos
        self.createTable()
        self.createClientsTable()

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
        self.createAdmin()  # Crea el usuario adminnistrador

    # Crea la tabla de clientes
    def createClientsTable(self):
        sql_create_clients_table = """
        CREATE TABLE IF NOT EXISTS clients(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        address TEXT,
        email TEXT,
        city TEXT,
        zip_code INTEGER,
        phone INTEGER,
        user_id INTEGER,
        FOREIGN KEY(user_id) REFERENCES users(id)
        )
        """
        cur = self.con.cursor()
        cur.execute(sql_create_clients_table)
        cur.close()

    # Crea el usuario administrador si ya existe lanza excepcion
    def createAdmin(self):
        cur = self.con.cursor()
        # Verifica si el usuario administrador ya existe
        cur.execute("SELECT * FROM users WHERE username = ?", (ADMIN_USERNAME,))
        if cur.fetchone():
            print(f"El usuario administrador {ADMIN_USERNAME} ya existe")
            cur.close()
            return

        try:
            sql_insert = """
            INSERT INTO users(username, email, password) values(?, ?, ?)
            """
            cur.execute(
                sql_insert, (ADMIN_USERNAME, ADMIN_EMAIL, encriptAdminPass)
            )  # Pasa los valores aquí
            self.con.commit()
            print("Usuario creado")
            cur.close()
        except Exception as error:
            print(f"El usuario {error} ya existe")

    def connect(self):
        return self.con
