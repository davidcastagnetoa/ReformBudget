# This Python file uses the following encoding: utf-8
from PySide2.QtCore import QObject, Qt, Signal, Property, Slot

# from PySide2.QtCore import QObject, Qt, Slot, Signal, QUrl, QTimer
import sys
import os

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine

from models.client import Client
from models.budget import Budget

from dotenv import load_dotenv, set_key

load_dotenv()
env_file = ".env"

USERNAME_RB = os.getenv("USERNAME_RB")
EMAIL_RB = os.getenv("PASSWORD_RB")
PASSWORD_RB = os.getenv("PASSWORD_RB")
RPT_PASSWORD_RB = os.getenv("PASSWORD_RB")


def createLocalEnv():
    env_contain = ""
    with open(env_file, "w") as key_file:
        key_file.write(env_contain)
    # os.system(f"attrib +s +h {env_file}")


# Clase para carga de variables de entorno, en PRODUCCIÓN cargará credenciales de DB
class EnvironmentVariables(QObject):
    userLogin = Signal(str, str)

    def __init__(self, parent=None):
        super(EnvironmentVariables, self).__init__(parent)
        self._username = USERNAME_RB
        self._password = PASSWORD_RB

    @Slot(str, str)
    def user_login(self, username, password):
        self.userLogin.emit(self._username, self._password)

        if self._username == None:
            self.userLogin.emit(
                "No existe usuario debe crear una cuenta", None)

        if self._username == username and self._password == password:
            self.userLogin.emit("Acceso granted", None)


# Clase para creacion de usuarios,  en PRODUCCIÓN guardará credenciales de DB
class UserHandler(QObject):
    # Esta señal se emitirá después de crear el usuario
    userCreated = Signal(str)

    if not os.path.exists(env_file):
        createLocalEnv()

    @Slot(str, str, str, str)
    def create_user(self, username, email, password, rptPassword):
        # Aquí implementas la lógica para crear un usuario.
        # Finalmente, emites la señal userCreated

        if username == "" or password == "":
            self.userCreated.emit("Ningún campo puede quedar vacío")
            return

        if password != rptPassword:
            self.userCreated.emit("Las contraseñas no coinciden.")
            return

        if username == USERNAME_RB:
            self.userCreated.emit("Este usuario ya existe.")
            return

        # Cifrar la contraseña (esto es un paso crucial que debes investigar más)
        encrypted_password = password  # Aquí debes implementar un método de cifrado

        # Cargar el archivo .env si existe
        load_dotenv(".env")

        # Guardar las variables en el archivo .env
        set_key(".env", "USERNAME_RB", username)
        set_key(".env", "EMAIL_RB", email)
        set_key(".env", "PASSWORD_RB", encrypted_password)

        self.userCreated.emit(
            "User created successfull"
        )  # Finalmente, emites la señal userCreated correcta


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


# # Crear un cliente. ejemplo
# client_01 = Client(
#     "Juan Perez", "Calle Falsa 123", "juan@email.com", "Madrid", "28001", "+34123456789"
# )
# # Crear un presupuesto
# budget_001 = Budget("001")

# # Agregar el presupuesto al cliente
# client_01.agregar_presupuesto(budget_001)

# # Recuperar un presupuesto específico del cliente
# presupuesto_recuperado = client_01.obtener_presupuesto("001")
# if presupuesto_recuperado:
#     print(f"Presupuesto recuperado: {presupuesto_recuperado.numero_budget}")
# else:
#     print("Presupuesto no encontrado.")


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # CARGANDO DE CLASES:
    # Carga la clase EnvironmentVariables
    env_variables = EnvironmentVariables()
    engine.rootContext().setContextProperty("envVariables", env_variables)

    # Carga la clase UserHandler
    user_handler = UserHandler()
    engine.rootContext().setContextProperty("userHandler", user_handler)

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
