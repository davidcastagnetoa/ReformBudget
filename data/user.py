import connection as con
from models.user import User


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
