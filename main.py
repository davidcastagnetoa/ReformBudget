# This Python file uses the following encoding: utf-8
from PySide2.QtCore import QObject, Signal, Property, Slot
import sys
import os

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine

from models.client import Client
from models.budget import Budget

from dotenv import load_dotenv

load_dotenv()

USERNAME_RB = os.getenv("USERNAME_RB")
PASSWORD_RB = os.getenv("PASSWORD_RB")


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


# Crear un cliente. ejemplo
client_01 = Client("Juan Perez", "Calle Falsa 123",
                   "juan@email.com", "Madrid", "28001", "+34123456789")
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
