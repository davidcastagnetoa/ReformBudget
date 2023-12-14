# database.py
import sqlite3
from models.client import Client
from models.budget import Budget


class Database:
    def __init__(self, db_name="users.db"):
        self.con = sqlite3.connect(db_name)
        self.cur = self.con.cursor()

    def getAllClients(self, limit=None):
        query = (
            "SELECT name, address, email, city, zip_code, phone, user_id FROM clients"
        )

        # if limit:
        #     query += " LIMIT ?"
        #     self.cur.execute(query, (limit,))
        # else:
        #     self.cur.execute(query)

        self.cur.execute(query)
        rows = self.cur.fetchall()
        # Convertir cada fila en un objeto Cliente y añadirlo a la lista 'clients'
        clients = [
            Client(
                name=row[0],
                address=row[1],
                email=row[2],
                city=row[3],
                zip_code=row[4],
                phone=row[5],
                user_id=row[6],  # Feature Key = PRIMARY KEY OF USERS
            )
            for row in rows
        ]
        return clients

    def getClientsForUserId(self, userId):
        query = "SELECT name, address, email, city, zip_code, phone, user_id FROM clients WHERE user_id = ?"
        self.cur.execute(query, (userId,))
        rows = self.cur.fetchall()
        # Convertir cada fila en un objeto Cliente y añadirlo a la lista 'clients'
        clients = [
            Client(
                name=row[0],
                address=row[1],
                email=row[2],
                city=row[3],
                zip_code=row[4],
                phone=row[5],
                user_id=row[6],  # Feature Key = PRIMARY KEY OF USERS
            )
            for row in rows
        ]
        return clients

    def getBudgetsForClientId(self, clientId):
        query = "SELECT budgetId, budgetName, budgetAmountSubtotal, budgetAmountTaxes, budgetAmountTotal, budgetDate,  budgetStatus, budgetType, budgetCategory, budgetSubcategory, budgetNotes, client_id FROM budgets WHERE client_id = ?"
        self.cur.execute(query, (clientId,))
        rows = self.cur.fetchall()
        # Convertir cada fila en un objeto Budget y añadirlo a la lista 'budgets'
        budgets = [
            Budget(
                budgetId=row[0],  # Integer
                budgetName=row[1],  # String
                budgetAmountSubtotal=row[2],  # Integer (in cents)
                budgetAmountTaxes=row[3],  # Integer (in cents)
                budgetAmountTotal=row[4],  # Integer (in cents)
                budgetDate=row[5],  # String
                budgetStatus=row[6],
                budgetType=row[7],
                budgetCategory=row[8],
                budgetSubcategory=row[9],
                budgetNotes=row[10],
                client_id=row[11],  # Feature Key = PRIMARY KEY OF CLIENTS
            )
            for row in rows
        ]
        return budgets

    def close(self):
        self.cur.close()
        self.con.close()
