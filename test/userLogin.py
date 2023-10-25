import connection as con
from PySide2.QtCore import QObject, Qt, Signal, Property, Slot


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


# data/user
class UserData:
    def login(self, user: User):
        self.db = con.ConnectionDB().connect()
        self.cursor = self.db.cursor()
        res = self.cursor.execute(
            "SELECT * FROM users WHERE username = ? AND password = ?",
            (user._username, user._password),
        )
        row = res.fetchone()

        # Cerrar el cursor.
        self.cursor.close()

        # Cerrar la conexión a la base de datos.
        self.db.close()

        if row:
            user = User(username=row[1], email=row[2], password=row[3])
            return user
        else:
            return None


# En desarrollo aun no en uso
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
        user = User(username, password)
        userData = UserData()
        response = userData.login(user)

        # Primero, comprobar si el nombre de usuario existe.
        if self._username is None:
            print("No existe usuario debe crear una cuenta")
            self.userLoged.emit("No existe usuario debe crear una cuenta", None)
            return  # Sal del método aquí.

        if response:
            print("user logged")
            self._username = username
            # self._password = password
            self.userLoged.emit("Access granted", None)
            self.loggedUsername = self._username
        else:
            print("Incorrect data!")
            self.userLoged.emit("Incorrect data!", None)
