from system.core.controller import *

class Quotes(Controller):
    def __init__(self, action):
        super(Quotes, self).__init__(action)
        self.load_model('User')
        self.load_model('Quote')
        self.db = self._app.db
   
    def index(self):
        quotes = self.models['Quote'].get_quotes()
        favorites = self.models['Quote'].get_favorites(session['id'])
        return self.load_view('quotes.html',quotes=quotes,favorites=favorites)

    def create(self):
        form_data = request.form
        id = session['id']
        create_status = self.models['Quote'].add_quote(form_data,id)
        if create_status['status']==True:
            print "Status: successfully added quote"
            return redirect('/quotes')
        else:
            for message in create_status['errors']:
                flash(message,'error')
            return redirect('/quotes')

    def favorite(self,id):
        quote_id = id
        user_id = session['id']
        print "quote",quote_id
        print "user",user_id
        self.models['Quote'].add_favorite(quote_id,user_id)
        return redirect('/quotes')

    def remove(self,id):
        quote_id = id
        self.models['Quote'].remove(quote_id)
        return redirect('/quotes')
