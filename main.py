# This Python file uses the following encoding: utf-8
from PySide2.QtCore import QObject, Signal, Property, Slot
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
    your_Username = ""
    your_Password = ""
    your_Keyword = ""
    your_Email = ""
    your_phone = ""
    env_contain = f"USERNAME_RB={your_Username}\nEMAIL_RB={your_Email}\nPASSWORD_RB={your_Password}\nKEY={your_Keyword}\nPHONE={your_phone}"
    with open(env_file, "w") as key_file:
        key_file.write(env_contain)
    # os.system(f"attrib +s +h {env_file}")


if not os.path.exists(env_file):
    # Crear una ventana que permita al usuario introducir su mail ,
    # contraseña de mail para aplicaciones externas y su palabra clave
    createLocalEnv()


class EnvironmentVariables(QObject):
    def __init__(self, parent=None):
        super(EnvironmentVariables, self).__init__(parent)
        self._username = USERNAME_RB
        self._password = PASSWORD_RB

    @Property(str)
    def username(self):
        return self._username

    @Property(str)
    def password(self):
        return self._password


class UserHandler(QObject):
    userCreated = Signal(str)  # Esta señal se emitirá después de crear el usuario

    @Slot(str, str, str, str)
    def create_user(self, username, email, password, rptPassword):
        # Aquí implementas la lógica para crear un usuario.
        # Finalmente, emites la señal userCreated.

        if password != rptPassword:
            self.userCreated.emit(
                "Las contraseñas no coinciden."
            )  # Emites la señal userCreated de error.
            return

        # Cifrar la contraseña (esto es un paso crucial que debes investigar más)
        encrypted_password = password  # Aquí debes implementar un método de cifrado

        # Cargar el archivo .env si existe
        load_dotenv(".env")

        # Guardar las variables en el archivo .env
        set_key(".env", f"USER_{username.upper()}_USERNAME", username)
        set_key(".env", f"USER_{email.upper()}_EMAIL", email)
        set_key(".env", f"USER_{password.upper()}_PASSWORD", encrypted_password)

        self.userCreated.emit(
            "Usuario creado con éxito."
        )  # Finalmente, emites la señal userCreated correcta


# Crear un cliente. ejemplo
client_01 = Client(
    "Juan Perez", "Calle Falsa 123", "juan@email.com", "Madrid", "28001", "+34123456789"
)
# Crear un presupuesto
budget_001 = Budget("001")

# Agregar el presupuesto al cliente
client_01.agregar_presupuesto(budget_001)

# Recuperar un presupuesto específico del cliente
presupuesto_recuperado = client_01.obtener_presupuesto("001")
if presupuesto_recuperado:
    print(f"Presupuesto recuperado: {presupuesto_recuperado.numero_budget}")
else:
    print("Presupuesto no encontrado.")


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    env_variables = EnvironmentVariables()
    engine.rootContext().setContextProperty("envVariables", env_variables)

    user_handler = UserHandler()
    engine.rootContext().setContextProperty("userHandler", user_handler)

    # engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml")) # Borrar en Producccion
    engine.load(os.path.join(os.path.dirname(__file__), "qml/loginPage.qml"))

    login_window = engine.rootObjects()[0]

    def close_login():
        login_window.close()

    # Connect the signal to the close function
    login_window.loginSuccessful.connect(close_login)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())

# Developed by David Castagneto
