require 'data_mapper'

if ENV['DATABASE_URL']
  DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
else
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
end

# Internship listing database
class Listing
    include DataMapper::Resource
    property :id, Serial
    property :title, Text
    property :logo, Text
    property :description, Text
    property :skills, Text
    property :l_url, Text
    property :location, Text
    property :company, Text
    property :count, Integer

end


get '/listings' do
   authenticate!
   # If it is a FREE user, show only 10 internships
   if (current_user.pro == false && current_user.administrator == false)
      @lastings = Listing.all(:id.gt => 0, :id.lt => 16)
      erb :listings
    # If it is a PRO user, show internships that have one matched skill or more
   elsif (current_user.pro == true)
      @lastings = Listing.all(:count.gt=> 1)
      erb :listings
   # Else (administrator), show all internships
   else
    @lastings = Listing.all
    erb :listings
  end
end

# Seperate endpoint for a user's preferred location, since the database can
# not be shared by the same instance variable
get '/listings/preferred-location' do
  pro_only!
  if (current_user.preferred_location != nil)
    @lastings = Listing.all(:count.gt => 1,:location => current_user.preferred_location)
    erb :listings
  else
  return "You do not have any preferred locations!"
end
end

# GET request to new_listing erb file that displays a form for administrators
# to upload an internship listing to the databse
get '/listings/new' do
   authenticate!
   administrator!
   erb :new_listing
end

# POST request that adds a new listing to the database
post '/create' do
   if params["title"] && params["description"] && params["logo"] && params["l_url"] && params["skills"] && params["company"] && params["location"] != nil
      j = Listing.new
      j.title = params["title"]
      j.description = params["description"]
      j.logo = params["logo"]
      j.l_url = params["l_url"]
      j.skills = params["skills"]
      j.company = params["company"]
      j.location = params["location"]
      j.save
      return erb :new_listing
   else
      return "Error! You're missing a parameter. "
   end
end
