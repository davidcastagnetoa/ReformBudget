import connection as con
from PySide2.QtCore import QObject, Qt, Signal, Property, Slot
import os
import platform
import hashlib
import base64
from cryptography.fernet import Fernet
from dotenv import load_dotenv


# Generamos la llave de encriptacion y la guardamos en un archivo .key
def generate_key(key):
    hashed_key = hashlib.sha256(key.encode("utf-8")).digest()
    key_hashed_encoded = base64.urlsafe_b64encode(hashed_key)
    filename = "pylon.key"

    if os.path.exists("pylon.key") and platform.system() == "Windows":
        os.system(f"attrib -s -h {filename}")

    with open(filename, "wb") as file:
        file.write(key_hashed_encoded)
        if platform.system() == "Windows":
            os.system(f"attrib +s +h {filename}")
        else:
            filename = "." + filename


# Cargamos la llave
def load_key():
    filename = "pylon.key"
    return open(filename, "rb").read()


# Encriptar contraseña para su almacenamiento
def encriptedPassword(message, key):
    f = Fernet(key)
    encrypted_message = f.encrypt(message.encode())
    return encrypted_message


# Desencriptamos la contraseña para su uso
def decryptedPassword(encrypted_message, key):
    f = Fernet(key)
    decrypted_message = f.decrypt(encrypted_message).decode()
    return decrypted_message


load_dotenv()
env_file = ".env"

# Define tu llave para encriptar las contraseñas
KEY = os.getenv("KEY")
your_key_word = KEY if KEY else "Default_word"
generate_key(your_key_word)

# Carga la clave
key = load_key()


# model/user
class User:
    def __init__(
        self,
        username,
        email,
        password,
    ):
        self._username = username
        self._email = email
        self._password = password


class UserData:
    def login(self, user: User):
        self.db = con.ConnectionDB().connect()
        self.cursor = self.db.cursor()

        res = self.cursor.execute(
            "SELECT * FROM users WHERE username = ?", (user._username,)
        )
        row = res.fetchone()

        # Cerrar el cursor.
        self.cursor.close()

        # Cerrar la conexión a la base de datos.
        self.db.close()

        if row:
            stored_password = decryptedPassword(row[3], key)
            if stored_password == user._password:
                user = User(username=row[1], email=row[2],
                            password=stored_password)
                print(user)
                return user


# Clase para logarse
class Login(QObject):
    userLoged = Signal(str, str)
    loggedUsernameChanged = Signal()

    def __init__(self, parent=None):
        super(Login, self).__init__(parent)
        self._username = ""  # Esta es la variable con la que se compara, guardada en DB
        self._password = ""  # Esta es la variable con la que se compara, guardada en DB
        self._loggedUsername = ""

    # Asigna el nombre de usuario a la señal loggedUsernameChanged
    @Property(str, notify=loggedUsernameChanged)
    def loggedUsername(self):
        return self._loggedUsername

    @loggedUsername.setter
    def loggedUsername(self, value):
        if self._loggedUsername != value:
            self._loggedUsername = value
            self.loggedUsernameChanged.emit()

    # Emita la señal userLoged
    @Slot(str, str)
    # los argumentos username y password aqui son los que recibe de LoginPage.qml
    def user_login(self, username, password):
        # Catch user and password from DB
        user = User(
            username, None, password
        )  # Requiere 3 parametros username, email, password (ver en models.user.py), pero solo necesita dos
        userData = UserData()
        response = userData.login(user)

        # Primero, comprobar si el nombre de usuario existe.
        if self._username is None:
            print("No existe usuario debe crear una cuenta")
            self.userLoged.emit(
                "No existe usuario debe crear una cuenta", None)
            return

        if response:
            self._username = username
            # self._password = password
            self.userLoged.emit("Access granted", None)
            self.loggedUsername = self._username
        else:
            print("Incorrect data!")
            self.userLoged.emit("Incorrect data!", None)
