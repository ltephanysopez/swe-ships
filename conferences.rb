require 'data_mapper'

if ENV['DATABASE_URL']
  DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
else
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
end

# Conferences database
class Conferences
    include DataMapper::Resource
    property :id, Serial
    property :title, Text
    property :logo, Text
    property :description, Text
    property :location, Text
    property :c_date, Text
    property :c_url, Text
    property :company, Text
    property :aid, Text
    property :deadline, Text
end


get '/conferences' do
   authenticate!
   @conference = Conferences.all
   erb :conferences
end


# GET request to new_listing erb file that displays a form for administrators
# to upload an internship listing to the databse
get '/conferences/new' do
   authenticate!
   administrator!
   erb :new_conference
end

# POST request that adds a new listing to the database
post '/create/conference' do
   if params["title"] && params["description"] && params["logo"] && params["location"] && params["c_date"] && params["c_url"] && params["company"] && params["aid"] && params["deadline"] != nil
      c = Conferences.new
      c.title = params["title"]
      c.description = params["description"]
      c.logo = params["logo"]
      c.location = params["location"]
      c.c_date = params["c_date"]
      c.c_url = params["c_url"]
      c.company = params["company"]
      c.aid = params["aid"]
      c.deadline = params["deadline"]
      c.save
      return erb :new_conference
   else
      return "Error! You're missing a parameter. "
   end
end
