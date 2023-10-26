import connection as con
from models.user import User
from utils.encrypter import criptedPassword, decriptedPassword, load_key

# Carga la clave
key = load_key()


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
            stored_password = decriptedPassword(row[3], key)
            if stored_password == user._password:
                user = User(username=row[1], email=row[2], password=stored_password)
                print(user)
                return user
        else:
            return None

    def user_Exists(self, username):
        self.db = con.ConnectionDB().connect()
        self.cursor = self.db.cursor()
        res = self.cursor.execute("SELECT * FROM users WHERE username = ?", (username,))
        row = res.fetchone()
        self.cursor.close()
        self.db.close()
        return bool(row)

    def email_Exists(self, email):
        self.db = con.ConnectionDB().connect()
        self.cursor = self.db.cursor()
        res = self.cursor.execute("SELECT * FROM users WHERE email = ?", (email,))
        row = res.fetchone()
        self.cursor.close()
        self.db.close()
        return bool(row)

    def create_User(self, user: User):
        self.db = con.ConnectionDB().connect()
        self.cursor = self.db.cursor()
        self.cursor.execute(
            "INSERT INTO users (username, email, password) VALUES (?, ?, ?)",
            (user._username, user._email, user._password),
        )
        self.db.commit()
        self.cursor.close()
        self.db.close()
        return user
