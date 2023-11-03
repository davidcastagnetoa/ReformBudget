# database.py
import sqlite3
# Asumiendo que tienes un archivo models/client.py con la definición de la clase Client.
from models.client import Client


class Database:
    def __init__(self, db_name="users.db"):
        self.con = sqlite3.connect(db_name)
        self.cur = self.con.cursor()

    def getAllClients(self, limit=None):
        query = "SELECT name, address, email, city, zip_code, phone, user_id FROM clients"
        if limit:
            query += " LIMIT ?"
            self.cur.execute(query, (limit,))
        else:
            self.cur.execute(query)

        rows = self.cur.fetchall()
        clients = []
        for row in rows:
            client = Client(name=row[0], address=row[1], email=row[2],
                            city=row[3], zip_code=row[4], phone=row[5], user_id=row[6])
            clients.append(client)
        return clients

    def getClientsForUserId(self, userId):
        query = "SELECT name, address, email, city, zip_code, phone, user_id FROM clients WHERE user_id = ?"
        self.cur.execute(query, (userId,))
        rows = self.cur.fetchall()
        # Convertir cada fila en un objeto Cliente y añadirlo a la lista 'clients'
        clients = [Client(name=row[0], address=row[1], email=row[2],
                          city=row[3], zip_code=row[4], phone=row[5], user_id=row[6]) for row in rows]
        return clients

    def close(self):
        self.cur.close()
        self.con.close()
