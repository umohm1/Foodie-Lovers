class UsersController < ApplicationController

  # GET: /
  get "/signup" do
    if !logged_in
    erb :index
  else
    redirect '/reviews'
  end

  # GET: //new
  get "/users/new" do
    erb :"//new.html"
  end

  # POST: /
  post "/users" do
    redirect "/"
  end

  # GET: //5
  get "/users/:id" do
    erb :"//show.html"
  end

  # GET: //5/edit
  get "/users/:id/edit" do
    erb :"//edit.html"
  end

  # PATCH: //5
  patch "/users/:id" do
    redirect "//:id"
  end

  # DELETE: //5/delete
  delete "/users/:id/delete" do
    redirect "/"
  end
end
end
