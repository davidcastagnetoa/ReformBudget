from PySide2.QtCore import QObject, Signal, Slot


class Client(QObject):
    def __init__(
        self,
        name="",
        address="",
        email="",
        city="",
        zip_code="",
        phone="",
        user_id=None,
        parent=None,
    ):
        super(Client, self).__init__(parent)  # Inicializa el QObject
        self._name = name
        self._address = address
        self._email = email
        self._city = city
        self._zip_code = zip_code
        self._phone = phone
        self._user_id = user_id

    # Método para crear el cliente
    def create_clients(self, name, address, email, city, zip_code, phone, user_id):
        self._name = name
        self._address = address
        self._email = email
        self._city = city
        self._zip_code = zip_code
        self._phone = phone
        self._user_id = user_id


# class ClientManager(QObject):
#     # Señal que emite el nombre, direccion, email, ciudad, cp, y telefono del cliente
#     clientCreated = Signal(str, str, str, str, str, str, int)
#     clientValidated = Signal(str)

#     def __init__(self, parent=None):
#         super(ClientManager, self).__init__(parent)
#         self._client = Client()  # Instancia vacía de cliente.

#     # # Función para crear un nuevo cliente y emitir la señal
#     @Slot(str, str, str, str, str, str, int)
#     def createClient(self, name, address, email, city, zip_code, phone, user_id):
#         if (
#             not name
#             or not address
#             or not email
#             or not city
#             or not zip_code
#             or not phone
#         ):
#             self.clientValidated.emit("Rellene todos los campos")
#             return

#         clientData = ClientData()
#         client = clientData.create_Client(
#             Client(name, address, email, city, zip_code, phone, user_id), user_id
#         )

#         if client is None:
#             self.userCreated.emit("Error al crear el cliente")
#             print("Error al crear el cliente")
#             return

#         self._client.create_clients(
#             name, address, email, city, zip_code, phone, user_id
#         )
#         self.clientCreated.emit(name, address, email, city, zip_code, phone, user_id)
#         self.clientValidated.emit("Cliente creado")


# class Client:
#     def __init__(self, nombre, direccion, email, ciudad, cp, telefono):
#         self.nombre = nombre
#         self.direccion = direccion
#         self.email = email
#         self.ciudad = ciudad
#         self.cp = cp
#         self.telefono = telefono
#         self.presupuestos = []  # Lista para guardar los presupuestos de este cliente

#     def agregar_presupuesto(self, presupuesto):
#         """Agrega un presupuesto a la lista de presupuestos del cliente."""
#         self.presupuestos.append(presupuesto)

#     def obtener_presupuesto(self, numero_budget):
#         """Devuelve un presupuesto específico basado en el número de presupuesto."""
#         for presupuesto in self.presupuestos:
#             if presupuesto.numero_budget == numero_budget:
#                 return presupuesto
#         return None  # Si no se encuentra el presupuesto con ese número

# # Crear un presupuesto
# budget_001 = Budget("001")

# # Agregar el presupuesto al cliente
# client_01.agregar_presupuesto(budget_001)

# # Recuperar un presupuesto específico del cliente
# presupuesto_recuperado = client_01.obtener_presupuesto("001")
# if presupuesto_recuperado:
#     print(f"Presupuesto recuperado: {presupuesto_recuperado.numero_budget}")
# else:
#     print("Presupuesto no encontrado.")
