import os
import platform
import hashlib
import base64
from cryptography.fernet import Fernet


# Generamos la llave de encriptacion y la guardamos en un archivo .key
def generate_key(key):
    hashed_key = hashlib.sha256(key.encode("utf-8")).digest()
    key_hashed_encoded = base64.urlsafe_b64encode(hashed_key)
    filename = "pylon.key"

    if os.path.exists("pylon.key") and platform.system() == "Windows":
        os.system(f"attrib -s -h {filename}")

    with open(filename, "wb") as file:
        file.write(key_hashed_encoded)
        if platform.system() == "Windows":
            os.system(f"attrib +s +h {filename}")
        else:
            filename = "." + filename


# Cargamos la llave
def load_key():
    filename = "pylon.key"
    return open(filename, "rb").read()


# Encriptar contraseña para su almacenamiento
def encriptedPassword(message, key):
    f = Fernet(key)
    encrypted_message = f.encrypt(message.encode())
    return encrypted_message


# Desencriptamos la contraseña para su uso
def decryptedPassword(encrypted_message, key):
    f = Fernet(key)
    decrypted_message = f.decrypt(encrypted_message).decode()
    return decrypted_message
