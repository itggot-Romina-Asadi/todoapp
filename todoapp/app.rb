class App < Sinatra::Base

	
	enable :sessions

	get '/' do
		slim (:index)
	end

	get '/login' do
		slim(:login)
	end

	get '/register' do
		slim (:register)
	end

	post '/register' do
		db = SQLite::Database.new("todoapp.sqlite")
		username = params[:username]
		password = params[:passsword]
		db.execute("INSERT INTO login (username, password) VALUES (?, ?)", [username,password])
	end

end           