# Pasar de euros a centimos (para almacenar en DB)
def eurs_to_cents(euros):
    cents = round(euros * 100)
    return cents


# Pasar de centimos a euros (Para uso en el cliente)
def cents_to_eurs(centavos):
    eurs = centavos / 100
    return eurs


client = input("Introduce valor en euros: ")
cents = eurs_to_cents(client)
# db = input("Introduce valor en centimos: ")
# eurs = cents_to_eurs(db)


print(f"valor a guardar en DB : {cents}")
# print(f"valor a mostrar en cliente : {eurs}")
