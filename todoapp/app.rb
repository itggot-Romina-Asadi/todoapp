class App < Sinatra::Base

	
	enable :sessions

	get '/' do
		slim (:index)
	end

	get '/register' do
		slim (:register)
	end

	post 'register' do
		db = SQLite::Database.new(Todoapp.sqlite)
		username = params[username]
		password = params[passsword]

		db.execute("INSERT INTO login (username, password) VALUES (?, ?)", [username,password])

	end

end           
