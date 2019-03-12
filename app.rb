require "sinatra"
require_relative "authentication.rb"
require_relative "user.rb"
require_relative "listing.rb"
require_relative "scholarships.rb"
require_relative "conferences.rb"
enable :sessions

#the following urls are included in authentication.rb
# GET /login
# GET /logout
# GET /sign_up

# authenticate! will make sure that the user is signed in, if they are not they will be redirected to the login page
# if the user is signed in, current_user will refer to the signed in user object.
# if they are not signed in, current_user will be nil

get "/" do
	@lastings = Listing.all
	erb :index
end

get "/terms-of-use" do
	erb :terms
end

get "/privacy-policy" do
	erb :privacy
end

