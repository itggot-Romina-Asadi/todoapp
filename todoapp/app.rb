class App < Sinatra::Base
	enable :sessions

	get '/' do
		slim (:index)
	end

	get '/login' do
		slim(:login)
	end

	post '/login' do
		db = SQLite3::Database.new("todoapp.sqlite")
		username = params["username"]
		password = params["password"]
		if password == db.execute("SELECT password FROM login WHERE username=?", [username])
			session[:username] = username
			redirect('/')
		end
	

		# db.execute("SELECT username WHERe id=i")
	end

	get '/register' do
		slim (:register)
	end

	post '/register' do
		db = SQLite3::Database.new("todoapp.sqlite")
		username = params["username"]
		password = params["password"]
		password2 = params["password2"]
		# Kryptera lösenord
		if password == password2
			db.execute("INSERT INTO login (username, password) VALUES (?, ?)", [username,password])
		else
			raise ArgumentError
			# Fixa argumenterror
		end
	end

end           