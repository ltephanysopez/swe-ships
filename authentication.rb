require 'sinatra'
require 'sinatra/flash'
require_relative "user.rb"

enable :sessions

set :session_secret, 'super secret'

get "/login" do
	erb :"authentication/login"
end


post "/process_login" do
	email = params[:email]
	password = params[:password]

	user = User.first(email: email.downcase)

	if(user && user.login(password))
		session[:user_id] = user.id
		redirect "/"
	else
		erb :"authentication/invalid_login"
	end
end

get "/logout" do
	session[:user_id] = nil
	redirect "/"
end

get "/sign_up" do
	erb :"authentication/sign_up"
end


post "/register" do
	#FREE users
	full_name = params[:full_name]
	email = params[:email]
	password = params[:password]

	#Check domain = "@gmail.com"
	domain = "@gmail.com"
	e_length = email.length
	e_domain = email[(e_length-10),10]

	if(e_domain == domain)
		u = User.new
		u.email = email.downcase
		u.full_name = full_name
		u.password =  password
		u.save
		session[:user_id] = u.id
		redirect "/"
	else
		erb :"authentication/invalid_signup"
	end
end

#This method will return the user object of the currently signed in user
#Returns nil if not signed in
def current_user
	if(session[:user_id])
		@u ||= User.first(id: session[:user_id])
		return @u
	else
		return nil
	end
end

#if the user is not signed in, will redirect to login page
def authenticate!
	if !current_user
		redirect "/login"
	end
end

#if the user is not an administrator, nor are they signed in, will redirect to login page
def administrator!
  if !current_user.administrator
	  redirect "/"
  end
end

def pro_only!
	if !current_user.pro
 	  redirect "/"
   end
 end

 get "/delete_listing/:id" do
	  administrator!
	  post = Listing.get(params[:id])
	  if post != nil
	  post.destroy
	  end
		 redirect "/listings"
 end
