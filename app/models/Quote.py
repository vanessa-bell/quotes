from system.core.model import Model

class Quote(Model):
    def __init__(self):
        super(Quote, self).__init__()

    def add_quote(self,form_data,id):
        errors = []
        if not form_data['speaker']:
            errors.append("'Quote from' cannot be blank")
        elif len(form_data['speaker']) < 4:
            errors.append("'Quote from' must be more than 3 characters long")  
        if not form_data['quote']:
            errors.append("Quote cannot be blank")
        elif len(form_data['quote']) < 11:
            errors.append("Quote must be more than 10 characters long")
        if errors:
            return {'status': False, 'errors':errors}
        else:
            sql = "INSERT INTO quotes (speaker, quote, created_at, updated_at, user_id) values(:speaker, :quote, NOW(), NOW(), :user_id)"
            data = {'speaker':form_data['speaker'],'quote':form_data['quote'],'user_id':id}
            self.db.query_db(sql,data)
            return {'status':True}

    def get_quotes(self):
        query = "SELECT quotes.user_id as user_id, speaker, quote, quotes.id as quote_id, alias from quotes JOIN users on quotes.user_id = users.id"
        return self.db.query_db(query)


    def get_user_quotes(self,id):
        query = "SELECT * from quotes WHERE user_id=:id"
        data = {'id':id}
        return self.db.query_db(query,data)

    def add_favorite(self,quote_id,user_id):
        sql = "INSERT INTO favorites (user_id, quote_id, created_at, updated_at) values(:user_id,:quote_id,NOW(),NOW())"
        data = {'user_id': user_id,'quote_id':quote_id}
        self.db.query_db(sql,data)
        return True

    def get_favorites(self,id):
        query ="SELECT alias, quote, speaker, favorites.user_id as user_id, favorites.quote_id as quote_id, quotes.user_id as created_id from favorites JOIN quotes on favorites.quote_id = quotes.id JOIN users on quotes.user_id = users.id WHERE favorites.user_id = :id"
        data = {'id':id}
        return self.db.query_db(query,data)

    def remove(self,id):
        query = "DELETE from favorites WHERE quote_id=:id"
        data = {'id':id}
        return self.db.query_db(query,data)

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