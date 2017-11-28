class App < Sinatra::Base
	enable :sessions

	get '/' do
		slim (:index)
	end

	get '/login' do
		slim(:login)
	end

	get '/start' do
		slim(:start)
	end	



	post '/login' do
		db = SQLite3::Database.new("todoapp.sqlite")
		username = params["username"]
		password = params["password"]
		password_digest = db.execute("SELECT password FROM login WHERE username='#{username}'").join
		password_digest = BCrypt::Password.new(password_digest)
		if password_digest == password
			session[:username] = username
			redirect('/start')
		else
			redirect('/register')
		end
	end

	get '/register' do
		slim (:register)
	end

	post '/register' do
		db = SQLite3::Database.new("todoapp.sqlite")
		username = params["username"]
		password = params["password"]
		password2 = params["password2"]
		password_digest = BCrypt::Password.create("#{password}")
		if password == password2
			db.execute("INSERT INTO login (username, password) VALUES (?, ?)", [username,password_digest])
			redirect('/login')
		else
			raise ArgumentError
			# Fixa argumenterror
		end
	end

end           