class UsersController < ApplicationController

  get '/signup' do
    if !logged_in
      erb :'users/create_user'
    else
      redirect '/reviews'
    end
  end

  post 'signup' do
    if params[:username].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = @user_id
      redirect '/reviews'
    end
  end 


end
