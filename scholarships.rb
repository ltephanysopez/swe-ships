require 'data_mapper'

if ENV['DATABASE_URL']
  DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
else
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
end

# Scholarships listing database
class Scholarships
    include DataMapper::Resource
    property :id, Serial
    property :title, Text
    property :logo, Text
    property :description, Text
    property :s_url, Text
    property :company, Text
    property :deadline, Text
    property :amount, Text
end


get '/scholarships' do
   authenticate!
   @scholarship = Scholarships.all
   erb :scholarships
end


# GET request to new_listing erb file that displays a form for administrators
# to upload an internship listing to the databse
get '/scholarships/new' do
   authenticate!
   administrator!
   erb :new_scholarship
end

# POST request that adds a new listing to the database
post '/create/scholarship' do
   if params["title"] && params["description"] && params["logo"] && params["s_url"] && params["company"] && params["amount"] && params["deadline"] != nil
      z = Scholarships.new
      z.title = params["title"]
      z.description = params["description"]
      z.logo = params["logo"]
      z.s_url = params["s_url"]
      z.company = params["company"]
      z.deadline = params["deadline"]
      z.amount = params["amount"]
      z.save
      return erb :new_scholarship
   else
      return "Error! You're missing a parameter. "
   end
end
