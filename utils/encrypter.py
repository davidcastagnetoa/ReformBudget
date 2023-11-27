from cryptography.fernet import Fernet
import base64
import hashlib
import platform
import os
from dotenv import load_dotenv

load_dotenv()
env_file = ".env"


# Creamos la variable local con las claves de acceso .env
def createLocalEnv():
    env_contain = "ADMIN_USERNAME='default_username'\n"
    env_contain += "ADMIN_EMAIL='default_email'\n"
    env_contain += "ADMIN_PASS='default_password'\n"
    env_contain += 'KEY="Ante una mente tranquila, el universo entero se rinde"'

    with open(env_file, "w") as key_file:
        key_file.write(env_contain)
    os.system(f"attrib +s +h {env_file}")


if not os.path.exists(env_file):
    createLocalEnv()
    load_dotenv()

# Cargamos la llave de encriptacion
KEY = os.getenv("KEY")
your_key_word = KEY


# Generamos la llave de encriptacion y la guardamos en un archivo .key
def generate_key(key):
    hashed_key = hashlib.sha256(key.encode("utf-8")).digest()
    key_hashed_encoded = base64.urlsafe_b64encode(hashed_key)

    filename = os.path.abspath("pylon.key")

    if os.path.exists("pylon.key") and platform.system() == "Windows":
        os.system(f"attrib -s -h {filename}")

    with open(filename, "wb") as file:
        file.write(key_hashed_encoded)
        print(f"Archivo pylon.key creado en: {filename}")
        if platform.system() == "Windows":
            os.system(f"attrib +s +h {filename}")
        else:
            filename = "." + filename


# Ejecutamos la funcion de crear llave en caso de no existir
if not os.path.exists(os.path.abspath("pylon.key")):
    generate_key(your_key_word)


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


# Cargamos la llave
def load_key():
    filename = os.path.abspath("pylon.key")
    print(f"Cargando llave desde: {filename}")
    return open(filename, "rb").read()
