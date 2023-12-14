import connection as con
from models.budget import Budget


class BudgetData:
    def add_Budget(self, budget: Budget, client_id: int):
        print("client_id recibido es: ", client_id)

        self.db = con.ConnectionDB().connect()
        self.cursor = self.db.cursor()
        self.cursor.execute(
            "INSERT INTO budgets (budgetId, budgetName, budgetAmountSubtotal, budgetAmountTaxes, budgetAmountTotal, budgetDate, budgetStatus, budgetType, budgetCategory, budgetNotes, client_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            (
                budget._budgetId,
                budget._budgetName,
                budget._budgetAmountSubtotal,
                budget._budgetAmountTaxes,
                budget._budgetAmountTotal,
                budget._budgetDate,
                budget._budgetStatus,
                budget._budgetType,
                budget._budgetCategory,
                budget._budgetNotes,
                client_id,
            ),
        )
        self.db.commit()
        self.cursor.close()
        self.db.close()
        return budget
