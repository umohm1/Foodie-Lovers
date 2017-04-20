class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/reviews'
    end
  end

  post '/signup' do
    @user = User.new(params)
     if @user.save
       session[:user_id] = @user.id
       redirect '/reviews'
     else
       flash[:message] = @user.errors.full_messages.join(", ")
       redirect '/signup'
     end
   end
    # if params[:username].empty? || params[:password].empty? #no sign-up w/o username or pw
    #   flash[:message] = "Your username or password can't be empty."
    #   redirect '/signup'
    # else
    #   @user = User.create(username: params[:username], password: params[:password])
    #   session[:user_id] = @user.id
    #   redirect '/reviews'
    # end


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
      flash[:message] = "Your username or password were incorrect. Please try again."
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
