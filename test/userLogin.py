from PySide2.QtCore import QObject, Signal, Slot
import sqlite3
import os
from dotenv import load_dotenv
from utils.encrypter import encriptedPassword, load_key


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
        cur.execute("SELECT * FROM users WHERE username = ?",
                    (ADMIN_USERNAME,))
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
            print("Usuario administrador creado")
            cur.close()
        except Exception as error:
            print(f"El usuario {error} ya existe")

    def connect(self):
        return self.con


class Client(QObject):
    def __init__(
        self,
        name="",
        address="",
        email="",
        city="",
        zip_code="",
        phone="",
        user_id=None,
        parent=None,
    ):
        super(Client, self).__init__(parent)  # Inicializa el QObject
        self._name = name
        self._address = address
        self._email = email
        self._city = city
        self._zip_code = zip_code
        self._phone = phone
        self._user_id = user_id

    # Método para crear el cliente
    def update_info(self, name, address, email, city, zip_code, phone, user_id):
        self._name = name
        self._address = address
        self._email = email
        self._city = city
        self._zip_code = zip_code
        self._phone = phone
        self._user_id = user_id


class ClientData:
    def create_Client(self, client: Client, user_id: int):
        print("user_id recibido es: ", user_id)

        self.db = con.ConnectionDB().connect()
        self.cursor = self.db.cursor()
        self.cursor.execute(
            "INSERT INTO clients (name, address, email, city, zip_code, phone, user_id) VALUES (?, ?, ?, ?, ?, ?, ?)",
            (
                client._name,
                client._address,
                client._email,
                client._city,
                client._zip_code,
                client._phone,
                user_id,
            ),
        )
        self.db.commit()
        self.cursor.close()
        self.db.close()
        return client


# Clase para la creacion de clientes
class ClientManager(QObject):
    # Señal que emite el nombre, direccion, email, ciudad, cp, y telefono del cliente
    clientCreated = Signal(str, str, str, str, str, str, int)
    clientValidated = Signal(str)

    def __init__(self, parent=None):
        super(ClientManager, self).__init__(parent)
        self._client = Client()  # Instancia vacía de cliente.

    # # Función para crear un nuevo cliente y emitir la señal
    @Slot(str, str, str, str, str, str, int)
    def createClient(self, name, address, email, city, zip_code, phone, user_id):
        if (
            not name
            or not address
            or not email
            or not city
            or not zip_code
            or not phone
        ):
            self.clientValidated.emit("Rellene todos los campos")
            return

        clientData = ClientData()
        client = clientData.create_Client(
            Client(name, address, email, city,
                   zip_code, phone, user_id), user_id
        )

        if client is None:
            self.userCreated.emit("Error al crear el cliente")
            print("Error al crear el cliente")
            return

        self._client.update_info(
            name, address, email, city, zip_code, phone, user_id
        )
        self.clientCreated.emit(name, address, email,
                                city, zip_code, phone, user_id)
        self.clientValidated.emit("Cliente creado")
