# This Python file uses the following encoding: utf-8
# from PySide2.QtCore import QUrl, QTimer
import sys
import os
from PySide2.QtCore import QObject, Qt, Signal, Property, Slot
from utils.encrypter import generate_key, load_key, encriptedPassword
from PySide2.QtGui import QGuiApplication, QIcon
from PySide2.QtQml import QQmlApplicationEngine
from data.user import UserData
from data.client import ClientData
from data.budget import BudgetData
from models.user import User
from models.client import Client
from models.budget import Budget
from connection import ConnectionDB
from utils.helpers import *
from dotenv import load_dotenv
from data.database import Database


def createLocalEnv():
    env_contain = ""
    with open(env_file, "w") as key_file:
        key_file.write(env_contain)
    os.system(f"attrib +s +h {env_file}")


load_dotenv()
env_file = ".env"

DEFAULT_ADMIN_USERNAME = "default_username"
ADMIN_USERNAME = os.getenv("ADMIN_USERNAME", DEFAULT_ADMIN_USERNAME)

if not os.path.exists(env_file):
    createLocalEnv()

# Carga la clave de desencriptación
key = load_key()


# Verifica si el archivo users.db existe
if not os.path.exists("users.db"):
    # Si no existe, crea la conexión y llama al método para inicializar la DB y crear el usuario administrador
    db_connection = ConnectionDB()
    db_connection.init_db()

# ConnectionDB().init_db()  # Para Pruebas, crear y actualizar tablas de DB. borrar linea en produccion


# Clase para logarse
class Login(QObject):
    userLoged = Signal(str, str)  # Señal de usuario logado
    loggedUsernameChanged = Signal()  # Señal de nombre de usuario
    userIdChanged = Signal(int)  # Señal para user_id de usuario
    clientsRetrieved = Signal(list)  # Señal para clientes del usuario

    def __init__(self, parent=None):
        super(Login, self).__init__(parent)
        self._username = ""
        self._password = ""
        self._loggedUsername = ""
        self._userId = None  # Nueva variable para guardar el user_id

    # Property para el user_id
    @Property(int, notify=userIdChanged)
    def userId(self):
        return self._userId

    @userId.setter
    def userId(self, value):
        if self._userId != value:
            self._userId = value
            self.userIdChanged.emit()

    # Property para el username
    @Property(str, notify=loggedUsernameChanged)
    def loggedUsername(self):
        return self._loggedUsername

    @loggedUsername.setter
    def loggedUsername(self, value):
        if self._loggedUsername != value:
            self._loggedUsername = value
            self.loggedUsernameChanged.emit()

    # Metodo para la consulta de clientes
    def getClientsForUser(self):
        db = Database()
        print(self._username)

        # Consulta de todos los cliente para el superusuario XD
        if self._username == ADMIN_USERNAME:
            clients = db.getAllClients(self._userId)
        # Consulta sólo de los clientes del usuario
        else:
            clients = db.getClientsForUserId(self._userId)
        clients_list = [
            {
                "name": client._name,
                "address": client._address,
                "email": client._email,
                "city": client._city,
                "zip_code": client._zip_code,
                "phone": client._phone,
                "user_id": client._user_id,
            }
            for client in clients
        ]
        print(clients_list)
        self.clientsRetrieved.emit(clients_list)
        db.close()

    # Metodo para logarse
    @Slot(str, str)
    def user_login(self, username, password):
        user = User(username, None, password)
        userData = UserData()
        response = userData.login(user)

        if response == "user_not_found":
            self.userLoged.emit(
                "No existe usuario debe crear una cuenta", None)
            return
        elif response == "incorrect_password":
            self.userLoged.emit("Contraseña incorrecta!", None)
            return
        elif isinstance(response, User):
            self._username = username
            self._userId = response._id
            print("El userId obtenido la clase Login es: ", self._userId)
            self.userLoged.emit("Acceso concedido", None)
            self.loggedUsername = self._username
            self.userId = (
                self._userId
            )  # Actualizar y emitir la nueva señal userIdChanged
            print("El userId obtenido la clase Login es: ", self.userId)
            # Obtener e imprimir clientes del usuario
            self.getClientsForUser()


# Clase para creacion de usuarios
class signUp(QObject):
    userCreated = Signal(str)
    loggedUsernameChanged = Signal()
    userIdChanged = Signal(int)  # Nueva señal para user_id

    def __init__(self, parent=None):
        super(signUp, self).__init__(parent)
        self._loggedUsername = ""
        self._userId = None  # Nueva variable para guardar el user_id

    @Property(int, notify=userIdChanged)
    def userId(self):
        return self._userId

    @userId.setter
    def userId(self, value):
        if self._userId != value:
            self._userId = value
            self.userIdChanged.emit()

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

        if username == "" or password == "" or email == "":
            self.userCreated.emit("Rellene todos los campos")
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
        encrypted_password = encriptedPassword(password, key)
        print("Antes de guardar:", encrypted_password)

        # Guardar username, email y password en DB
        user = userData.create_User(User(username, email, encrypted_password))
        self.loggedUsername = username

        if user is None:
            self.userCreated.emit("Error al crear el usuario")
            print("Error al crear el usuario")
            return

        self._userId = user._id  # Asigna el ID del usuario
        print("El userId obtenido la clase signUp es: ", self._userId)
        self.userId = self._userId  # Actualizar y emitir la nueva señal userIdChanged
        print("El userId obtenido la clase signUp es: ", self.userId)

        # Finalmente, emites la señal userCreated correcta
        self.userCreated.emit("User created successfull")


# Clase para la creacion de clientes
class ClientManager(QObject):
    # Señales
    clientCreated = Signal(
        str, str, str, str, str, str, int
    )  # nombre, direccion, email, ciudad, cp, telefono del cliente y id del usaurio al que pertenece el cliente
    clientEdited = Signal(
        str, str, str, str, str, str, int
    )  # nombre, direccion, email, ciudad, cp, telefono del cliente y id del usaurio al que pertenece el cliente
    clientValidated = Signal(str)  # Confirmacion de cliente creado
    clientUpgraded = Signal(str)  # Confirmacion de cliente editado

    def __init__(self, parent=None):
        super(ClientManager, self).__init__(parent)
        self._client = Client()  # Instancia vacía de cliente.

    # # Función para crear un nuevo cliente y emitir señales (aqui recibe los datos desde el lado del cliente)
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

        # Llama al Metodo Data que crea el cliente en la DB
        clientData = ClientData()

        # Creamos al cliente (Lo que guarda en DB)
        newClient = clientData.create_Client(
            Client(name, address, email, city,
                   zip_code, phone, user_id), user_id
        )

        # Validamos que el cliente se haya creado correctamente
        if newClient is None:
            self.clientCreated.emit("Error al crear el cliente")
            print("Error al crear el cliente")
            return

        # Aquí se debería emitir la señal clientCreated para su uso en el lado del cliente
        self.clientCreated.emit(name, address, email,
                                city, zip_code, phone, user_id)
        self.clientValidated.emit("Cliente creado")

    # Funcion para editar cliente (aun no en uso en cliente)
    @Slot(str, str, str, str, str, str, int)
    def updateClient(self, name, address, email, city, zip_code, phone, user_id):
        if (
            not name
            or not address
            or not email
            or not city
            or not zip_code
            or not phone
        ):
            self.clientValidated.emit("Debe al menos cambiar un campo")
            return

        clientData = ClientData()

        # Llama al Metodo Data que edita el cliente en la DB (aun en desarrollo)
        editedClient = clientData.update_Client(
            Client(name, address, email, city,
                   zip_code, phone, user_id), user_id
        )

        if editedClient is None:
            self.clientCreated.emit("Error al crear el cliente")
            print("Error al editar al cliente")
            return

        self.clientEdited.emit(name, address, email,
                               city, zip_code, phone, user_id)
        self.clientUpgraded.emit("Cliente editado")


# Clase para la creacion de presupuestos
class BudgetManager(QObject):
    # Señales
    budgetCreated = Signal(str, str, int, int, int, str,
                           str, str, str, str, str, int)
    budgetValidated = Signal(str)

    def __init__(self, parent=None):
        super(BudgetManager, self).__init__(parent)
        self._budget = Budget()  # Instancia vacía de cliente.

    # Funcion para crear presupuesto y emitir señales (aqui recibe los datos desde el lado del cliente)
    @Slot(str, str, float, float, float, str, str, str, str, str, str, int)
    def createBudget(
        self,
        budgetId,
        budgetName,
        budgetAmountSubtotal,
        budgetAmountTaxes,
        budgetAmountTotal,
        budgetDate,
        budgetDescription,
        budgetStatus,
        budgetType,
        budgetCategory,
        budgetNotes,
        client_id,
    ):
        if (
            not budgetId
            or not budgetName
            or not budgetAmountSubtotal
            or not budgetAmountTaxes
            or not budgetAmountTotal
            or not budgetDate
            or not budgetDescription
            or not budgetStatus
            or not budgetType
            or not budgetCategory
            or not budgetNotes
        ):
            self.budgetValidated.emit("Rellene todos los campos")
            return

        # Pasamos las cantidades desde el lado del cliente, de euros(float) a centimos(integer)
        budgetAmountSubtotal_inCents = eurs_to_cents(budgetAmountSubtotal)
        budgetAmountTaxes_inCents = eurs_to_cents(budgetAmountTaxes)
        budgetAmountTotal_inCents = eurs_to_cents(budgetAmountTotal)

        # # Pasamos la fecha desde el cliente a formato datetime
        # budgetDate = datetime.strptime(budgetDate, "%d/%m/%Y")
        # # Pasamos el status desde el cliente a formato booleano
        # budgetStatus = budgetStatus == "Activo"
        # # Pasamos el tipo desde el cliente a formato booleano
        # budgetType = budgetType == "Fijo"
        # # Pasamos la categoria desde el cliente a formato booleano
        # budgetCategory = budgetCategory == "Personal"
        # # Pasamos los notas desde el cliente a formato booleano
        # budgetNotes = budgetNotes == "Sin notas"

        # LLama al metodo Data que crea el presupuesto en la DB
        budgetData = BudgetData()

        # Creamos el presupuesto (Lo que guarda en DB)
        budget = budgetData.add_Budget(
            Budget(
                budgetId,
                budgetName,
                budgetAmountSubtotal_inCents,
                budgetAmountTaxes_inCents,
                budgetAmountTotal_inCents,
                budgetDate,
                budgetDescription,
                budgetStatus,
                budgetType,
                budgetCategory,
                budgetNotes,
                client_id,
            ),
            client_id,
        )

        # Validamos que el presupuesto se haya creado correctamente
        if budget is None:
            self.budgetCreated.emit("Error al crear el presupuesto")
            print("Error al crear el presupuesto")
            return

        # self._budget.update_info(budgetId, budgetName, budgetAmountSubtotal, budgetAmountTaxes, budgetAmountTotal, budgetDate, budgetDescription, budgetStatus, budgetType, budgetCategory, budgetNotes, client_id)  # For update budget

        # Pasamos las cantidades hacia el lado del cliente, de centimos(integer) a euros(float)
        budgetAmountSubtotal_inEurs = round(
            float(cents_to_eurs(budgetAmountSubtotal_inCents)), 2
        )
        budgetAmountTaxes_inEurs = round(
            float(cents_to_eurs(budgetAmountTaxes_inCents)), 2
        )
        budgetAmountTotal_inEurs = round(
            float(cents_to_eurs(budgetAmountTotal_inCents)), 2
        )

        # Aquí se debería emitir la señal budgetCreated (Lo que se envia al cliente)
        self.budgetCreated.emit(
            budgetId,
            budgetName,
            budgetAmountSubtotal_inEurs,
            budgetAmountTaxes_inEurs,
            budgetAmountTotal_inEurs,
            budgetDate,
            budgetDescription,
            budgetStatus,
            budgetType,
            budgetCategory,
            budgetNotes,
            client_id,
        )


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
    app.setWindowIcon(QIcon("./images/anera_ico.ico"))
    engine = QQmlApplicationEngine()

    # CARGA DE CLASES:
    # Carga la clase presupuestos
    budget_manager = BudgetManager()
    engine.rootContext().setContextProperty("budgetObj", budget_manager)

    # Carga la clase clientes
    client_manager = ClientManager()
    engine.rootContext().setContextProperty("clientObj", client_manager)

    # Carga la clase Login
    login_userdata = Login()
    engine.rootContext().setContextProperty("loginUser", login_userdata)

    # Carga la clase signUp
    signup_userdata = signUp()
    engine.rootContext().setContextProperty("signupUser", signup_userdata)

    # ARRANCANDO MOTORES DE VENTANA
    # engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))  # Borrar en Producccion
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
