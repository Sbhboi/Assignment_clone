require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'

require_relative 'models/movie.rb'
require_relative 'models/review.rb'
require_relative 'models/user.rb'

set :database, {adapter: 'postgresql', database: 'Evaritus'}

enable :sessions

get '/' do
  erb :index
end

get '/register' do 
  erb :'/register'
end 

post '/register' do 
  @user = User.new(name: params[:name], email: params[:email], password: params[:password])
  if @user.save
    session[:id] = @user.id
    redirect "/"
  else 
    erb :'login'
  end
end

get '/login' do 
  erb :'/login'
end

post '/login' do 
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password]) 
    session[:id] = user.id
    redirect "/"
  else 
    @error = "Incorrect email or password"
    erb :'/login'
  end
end

helpers do
  def logged_in?
    !session[:id].nil?
  end
end

delete '/logout' do 
  session.clear
  redirect "/"
end

get '/users/new' do 
  erb :'users/new'
end

post '/users' do 
  @user = User.new(email: params[:email], password: params[:password])
  if @user.save
    session[:id] = @user.id
    redirect "/"
  else 
    erb :'users/new'
  end
end