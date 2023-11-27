class User:
    def __init__(self, username, email, password, user_id=None):
        self._username = username
        self._email = email
        self._password = password
        self._id = user_id
