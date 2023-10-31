import connection as con
from models.user import User
from utils.encrypter import encriptedPassword, decryptedPassword, load_key

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
        self.cursor.close()
        self.db.close()

        if not row:
            return "user_not_found"

        stored_password = decryptedPassword(row[3], key)
        if stored_password != user._password:
            return "incorrect_password"
        user = User(
            username=row[1], email=row[2], password=stored_password, user_id=row[0]
        )
        print("El userId en el objeto usuario UserData y metodo Login es: ", user._id)
        return user

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
        user_id = self.cursor.lastrowid  # Obtiene el ID del último registro insertado
        self.cursor.close()
        self.db.close()
        user._id = user_id
        print(
            "El userId en el objeto usuario UserData y metodo create_User es: ",
            user._id,
        )
        return user
