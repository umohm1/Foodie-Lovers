class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/reviews'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? #no sign-up w/o username or pw
      redirect '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/reviews'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/reviews'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username]) #find the user
    if @user && @user.authenticate(params[:password]) #check password is a match
      session[:user_id] = @user.id   #log them in
      redirect '/reviews' #show them their reviews
    else
      erb :'users/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
end
