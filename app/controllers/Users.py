from system.core.controller import *
from time import strftime

class Users(Controller):
    def __init__(self, action):
        super(Users, self).__init__(action)
        self.load_model('User')
        self.load_model('Quote')
        self.db = self._app.db
   
    def index(self):
        return self.load_view('index.html')

    def create(self,methods=['POST']):
        user_info = request.form
        create_status = self.models['User'].create_new(user_info)
        if create_status['status'] == True:
            session['id'] = create_status['user']['id']
            session['alias'] = create_status['user']['alias']
            return redirect('/quotes')
        else:
            for message in create_status['errors']:
                flash(message, 'error')
            return redirect('/main')

    def login(self,methods=['POST']):
        info = request.form
        if self.models['User'].login_user(info) == False:
            flash("Invalid login!",'error')
            return redirect('/main')
        else:
            user = self.models['User'].login_user(info)
            session['id'] = user['id']
            session['alias'] = user['alias']
            return redirect('/quotes')

    def show(self,id):
        quotes = self.models['Quote'].get_user_quotes(id)
        user = self.models['User'].get_user(id)
        return self.load_view('profile.html',user=user[0],quotes=quotes)
    
    def logoff(self):
        session.pop('id')
        flash("You are now logged out",'error')
        return redirect('/main')