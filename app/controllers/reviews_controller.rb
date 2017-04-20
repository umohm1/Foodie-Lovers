class ReviewsController < ApplicationController


  get '/reviews' do
    if logged_in?
      @user_reviews = current_user.reviews
      @reviews = Review.where.not(user_id: current_user.id)
      erb :'reviews/index'
    else
      redirect '/login'
    end
  end

  get '/reviews/new' do
   if logged_in?
     erb :'reviews/new'
   else
     redirect '/login'
   end
 end

 post '/reviews' do
   review = current_user.reviews.build(params)
   if review.save
     redirect "/reviews/#{review.id}"
   else
     flash[:message] = "Sorry! Reviews must have a title, description, and rating. Please try again."
     redirect '/reviews/new'
   end
 end

 get '/reviews/:id' do #shows single review
   if logged_in?
     @review = Review.find_by_id(params[:id])
     erb :'reviews/show'
   else
     redirect '/login'
   end
 end

 get '/reviews/:id/edit' do #user can view edit form only if logged in
   if logged_in?
     @review = Review.find_by_id(params[:id])
     if @review.user_id == session[:user_id]
       erb :'reviews/edit'
     else
       redirect '/reviews'
     end
   else
     redirect '/login'
   end
 end


 patch '/reviews/:id' do
  @review = current_user.reviews.find_by_id(params[:id])
  #  @review = Review.find_by_id(params[:id])
  if @review
    if @review.update(params[:review])
     redirect '/reviews'
   else
     erb :'reviews/edit'
   end
   else
     redirect '/reviews'
   end
 end

 delete '/reviews/:id/delete' do
   if logged_in?
     @review = Review.find_by_id(params[:id])
     if @review.user_id == session[:user_id]
       @review.destroy
     end
     redirect '/reviews'
   else
     redirect '/login'
   end
 end
end
