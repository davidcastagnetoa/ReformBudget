class Client:
    def __init__(self, nombre, direccion, email, ciudad, cp, telefono):
        self.nombre = nombre
        self.direccion = direccion
        self.email = email
        self.ciudad = ciudad
        self.cp = cp
        self.telefono = telefono
        self.presupuestos = []  # Lista para guardar los presupuestos de este cliente

    def agregar_presupuesto(self, presupuesto):
        """Agrega un presupuesto a la lista de presupuestos del cliente."""
        self.presupuestos.append(presupuesto)

    def obtener_presupuesto(self, numero_budget):
        """Devuelve un presupuesto específico basado en el número de presupuesto."""
        for presupuesto in self.presupuestos:
            if presupuesto.numero_budget == numero_budget:
                return presupuesto
        return None  # Si no se encuentra el presupuesto con ese número
