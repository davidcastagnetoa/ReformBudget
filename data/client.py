import connection as con
from models.client import Client


class ClientData:
    def create_Client(self, client: Client, user_id: int):
        print("user_id recibido es: ", user_id)

        self.db = con.ConnectionDB().connect()
        self.cursor = self.db.cursor()
        self.cursor.execute(
            "INSERT INTO clients (name, address, email, city, zip_code, phone, user_id) VALUES (?, ?, ?, ?, ?, ?, ?)",
            (
                client._name,
                client._address,
                client._email,
                client._city,
                client._zip_code,
                client._phone,
                user_id,
            ),
        )
        self.db.commit()
        self.cursor.close()
        self.db.close()
        return client

    def update_Client(self, client: Client, user_id: int):
        print("user_id recibido es: ", user_id)
        pass
