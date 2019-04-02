     
require 'sinatra'
# require 'sinatra/reloader'
require 'pry'
require 'pg'
require 'active_record'

require_relative 'db_config'
require_relative 'models/product'
require_relative 'models/user'
require_relative 'models/review'

enable :sessions

helpers do # this sinatra working as erb files and rb file.

 def current_user
  user = User.find_by(id: session[:user_id])
 end

 def logged_in?

  if current_user
    true
  else
    false
  end

 end

end

get '/' do
  redirect '/login'
end


get '/products' do
  @products = Product.all
  erb :products
end

get '/products/new' do
  erb :new_products
end

post '/products' do
  product = Product.new
  product.name = params[:name]
  product.image_url = params[:image_url]
  product.user_id = session[:user_id]
  product.save

  redirect '/products'
end

get '/products/:id' do
  @product = Product.find(params[:id])
  @reviews = Review.where(product_id: params[:id])
  erb :products_detail
  
end

get '/products/:id/edit' do
  @product = Product.find(params[:id])
  erb :update_products
end

put '/products/:id' do
  product = Product.find(params[:id])
  product.name = params[:name]
  product.image_url = params[:image_url]
  product.user_id = session[:user_id]
  product.save

  redirect "/products/#{product.id}"
end

delete '/products/:id' do
  @product = Product.find(params[:id])
  @product.destroy
  redirect '/products'
end


get '/login' do
  erb :login
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  user = User.new
  user.name = params[:name]
  user.email = params[:email]
  user.password = params[:password]
  user.save
  redirect '/login'
end

post '/session' do

  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])

    # user logged in
    session[:user_id] = user.id
    
    # redirect to secure place
    redirect '/products'

  else
    erb :login
  end

end

delete '/session' do
  session[:user_id] = nil
  redirect '/login'
end

get '/my_products' do
  @products = Product.where(user_id: current_user.id)
  erb :my_products
end

post '/reviews' do
  review = Review.new
  review.star_rating = params[:star_rating]
  review.description = params[:description]
  review.user_id = session[:user_id]
  review.product_id = params[:product_id]
  review.save

  redirect "/products/#{params[:product_id]}"
end

get '/reviews' do
  @review = Review.all
  erb :review_form
end

