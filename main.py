# This Python file uses the following encoding: utf-8
# from PySide2.QtCore import QUrl, QTimer
from PySide2.QtCore import QObject, Qt, Signal, Property, Slot
import sys
import os
from PySide2.QtGui import QGuiApplication, QIcon
from PySide2.QtQml import QQmlApplicationEngine
from models.client import ClientManager
from data.user import UserData
from models.user import User
from utils.encrypter import generate_key, load_key, criptedPassword
from dotenv import load_dotenv


def createLocalEnv():
    env_contain = ""
    with open(env_file, "w") as key_file:
        key_file.write(env_contain)
    # os.system(f"attrib +s +h {env_file}")


load_dotenv()
env_file = ".env"

if not os.path.exists(env_file):
    createLocalEnv()


# Define tu llave para encriptar las contraseñas
KEY = os.getenv("KEY")
your_key_word = KEY if KEY else "Default_word"
generate_key(your_key_word)


# Carga la clave
key = load_key()


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

        if response == "user_not_found":
            print("No existe usuario debe crear una cuenta")
            self.userLoged.emit("No existe usuario debe crear una cuenta", None)
            return
        elif response == "incorrect_password":
            print("Incorrect password!")
            self.userLoged.emit("Incorrect password!", None)
            return
        elif isinstance(response, User):
            print("user logged")
            self._username = username
            self.userLoged.emit("Access granted", None)
            self.loggedUsername = self._username


# Clase para creacion de usuarios, en PRODUCCIÓN guardará credenciales de DB
class signUp(QObject):
    # Esta señal se emitirá después de crear el usuario
    userCreated = Signal(str)
    loggedUsernameChanged = Signal()

    def __init__(self, parent=None):
        super(signUp, self).__init__(parent)
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

    @Slot(str, str, str, str)
    def create_user(self, username, email, password, rptPassword):
        # Aquí implementas la lógica para crear un usuario.

        if username == "" or password == "":
            self.userCreated.emit("Ningún campo puede quedar vacío")
            return

        if password != rptPassword:
            self.userCreated.emit("Las contraseñas no coinciden.")
            return

        userData = UserData()
        if userData.user_Exists(username):
            self.userCreated.emit("Este usuario ya existe.")
            return

        if userData.email_Exists(email):
            self.userCreated.emit("Este email ya está registrado.")
            return

        # Cifrar la contraseña (esto es un paso crucial que debes investigar más)
        encrypted_password = criptedPassword(password, key)
        print("Antes de guardar:", encrypted_password)

        # Guardar username, email y password en DB
        user = userData.create_User(User(username, email, encrypted_password))
        self.loggedUsername = username

        if user is None:
            self.userCreated.emit("Error al crear el usuario")
            print("Error al crear el usuario")
            return

        print(userData)
        print(username)
        print(email)
        print(password)
        print(rptPassword)
        print(encrypted_password)

        # Finalmente, emites la señal userCreated correcta
        self.userCreated.emit("User created successfull")


# Clase para control de ventanas
class WindowManager(QObject):
    def __init__(self, window):
        super().__init__()
        self.window = window
        self.alwaysOnTop = False

    # Funcion para mostrar siempre por encima de las demas ventanas
    @Slot(bool)
    def setAlwaysOnTop(self, on_top):
        if on_top:
            self.window.setFlags(
                Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
            )
            self.alwaysOnTop = True
        else:
            self.window.setFlags(Qt.Window | Qt.FramelessWindowHint)
            self.alwaysOnTop = False
        self.window.show()

    # Boton que ejecuta la funcion setAlwaysOnTop()
    @Slot()
    def toggleAlwaysOnTop(self):
        self.setAlwaysOnTop(not self.alwaysOnTop)


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setWindowIcon(QIcon("./images/anera_ico.png"))
    engine = QQmlApplicationEngine()

    # CARGA DE CLASES:
    # Carga la clase para crear clientes
    client_manager = ClientManager()
    engine.rootContext().setContextProperty("clientObj", client_manager)

    # Carga la clase Login
    login_userdata = Login()
    engine.rootContext().setContextProperty("loginUser", login_userdata)

    # Carga la clase signUp
    signup_userdata = signUp()
    engine.rootContext().setContextProperty("signupUser", signup_userdata)

    # ARRANCANDO MOTORES DE VENTANA
    # engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))   # Borrar en Producccion
    engine.load(os.path.join(os.path.dirname(__file__), "qml/loginPage.qml"))

    # ASIGNANDO a primera posicion VENTANA loginPage
    login_window = engine.rootObjects()[0]

    # Carga la clase WindowManager
    window_manager = WindowManager(login_window)
    engine.rootContext().setContextProperty("WindowManager", window_manager)

    # FUNCION PARA CERRAR VENTANA

    def close_login():
        login_window.close()

    # Connect the signal to the close function
    login_window.loginSuccessful.connect(close_login)

    # FUNCION PARA CERRAR VENTANA
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())


# Developed by David Castagneto
