from PySide2.QtCore import QObject


class Budget(QObject):
    def __init__(
        self,
        budgetId="",
        budgetName="",
        budgetAmountSubtotal=int,
        budgetAmountTaxes=int,
        budgetAmountTotal=int,
        budgetDate="",
        budgetDescription="",
        budgetStatus="",
        budgetType="",
        budgetCategory="",
        budgetNotes="",
        client_id=None,  # Cliente al que pertenece
        parent=None,
    ):
        super(Budget, self).__init__(parent)  # Inicializa el QObject
        self._budgetId = budgetId
        self._budgetName = budgetName
        self._budgetAmountSubtotal = budgetAmountSubtotal
        self._budgetAmountTaxes = budgetAmountTaxes
        self._budgetAmountTotal = budgetAmountTotal
        self._budgetDate = budgetDate
        self._budgetDescription = budgetDescription
        self._budgetStatus = budgetStatus
        self._budgetType = budgetType
        self._budgetCategory = budgetCategory
        self._budgetNotes = budgetNotes
        self._client_id = client_id  # Cliente al que pertenece

    def updateBudget(
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
        client_id,  # Cliente al que pertenece
    ):
        self._budgetId = budgetId
        self._budgetName = budgetName
        self._budgetAmountSubtotal = budgetAmountSubtotal
        self._budgetAmountTaxes = budgetAmountTaxes
        self._budgetAmountTotal = budgetAmountTotal
        self._budgetDate = budgetDate
        self._budgetDescription = budgetDescription
        self._budgetStatus = budgetStatus
        self._budgetType = budgetType
        self._budgetCategory = budgetCategory
        self._budgetNotes = budgetNotes
        self._client_id = client_id  # Cliente al que pertenece

    def calculateAmountTaxes(self, budgetAmountSubtotal, iva, ice):
        self._budgetAmountSubtotal = budgetAmountSubtotal
        percentage_iva = iva
        percentage_ice = ice
        budgetAmountTaxes = (percentage_ice * budgetAmountSubtotal / 100) + (
            percentage_iva * budgetAmountSubtotal / 100
        )
        return budgetAmountTaxes

    def calculateAmountTotal(self, budgetAmountSubtotal, budgetAmountTaxes):
        budgetAmountTotal = budgetAmountSubtotal + budgetAmountTaxes
        return budgetAmountTotal
