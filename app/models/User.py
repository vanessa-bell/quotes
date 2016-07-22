from system.core.model import Model
import re

class User(Model):
    def __init__(self):
        super(User, self).__init__()

    def create_new(self, info):
        EMAIL_REGEX = re.compile(r'^[a-za-z0-9\.\+_-]+@[a-za-z0-9\._-]+\.[a-za-z]*$')
        NAME_REGEX = re.compile(r'^[a-zA-Z ]+$')
        errors = []
        if not info['full_name']:
            errors.append('Name cannot be blank')
        elif len(info['full_name']) < 2:
            errors.append('Name must be at least 2 characters long')
        elif not NAME_REGEX.match(info['full_name']):
            errors.append('Name must be letters only')
        if not info['email']:
            errors.append('Email cannot be blank')
        elif not EMAIL_REGEX.match(info['email']):
            errors.append('Email format must be valid!')
        if not info['password']:
            errors.append('Password cannot be blank')
        elif len(info['password']) < 8:
            errors.append('Password must be at least 8 characters long')
        elif info['password'] != info['confirm_pw']:
            errors.append('Password and confirmation must match!')
        if not info['dob']:
            errors.append('Date of Birth cannot be blank')
        if errors:
            print errors
            return {'status': False, 'errors':errors}
        else:    
            password = info['password']
            hashed_pw = self.bcrypt.generate_password_hash(password)
            create_query = "INSERT INTO users (full_name, alias, email, pw_hash, dob, created_at, updated_at) VALUES (:full_name, :alias, :email, :pw_hash, :dob, NOW(), NOW())"            
            create_data = {'full_name': info['full_name'], 'alias': info['alias'], 'email': info['email'], 'pw_hash': hashed_pw, 'dob': info['dob']}
            self.db.query_db(create_query, create_data)
            get_user_query = "SELECT * FROM users ORDER BY id DESC LIMIT 1"
            users = self.db.query_db(get_user_query)
            return {'status':True, 'user': users[0]}


    def login_user(self,info,methods='POST'):
        password = info['password']
        user_query = "SELECT * FROM users WHERE email = :email LIMIT 1"
        user_data = {'email': info['email']}
        user = self.db.get_one(user_query, user_data)
        if user:
            if self.bcrypt.check_password_hash(user.pw_hash, password):
                return user
        return False

    def get_user(self, id):
        query = "SELECT * from users where id = :id"
        data = {'id': id}
        return self.db.query_db(query, data)
    """
    Below is an example of a model method that queries the database for all users in a fictitious application
    
    Every model has access to the "self.db.query_db" method which allows you to interact with the database

    def get_users(self):
        query = "SELECT * from users"
        return self.db.query_db(query)

    def get_user(self):
        query = "SELECT * from users where id = :id"
        data = {'id': 1}
        return self.db.get_one(query, data)

    def add_message(self):
        sql = "INSERT into messages (message, created_at, users_id) values(:message, NOW(), :users_id)"
        data = {'message': 'awesome bro', 'users_id': 1}
        self.db.query_db(sql, data)
        return True
    
    def grab_messages(self):
        query = "SELECT * from messages where users_id = :user_id"
        data = {'user_id':1}
        return self.db.query_db(query, data)

    """