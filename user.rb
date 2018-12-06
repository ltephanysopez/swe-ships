require 'data_mapper'
require_relative 'listing.rb'
require 'stripe'

set :publishable_key, "pk_test_Y19q4uOMtZL9rfgh3uHTtEo5"
set :secret_key, "sk_test_aTWBdKlOMVvvoJtaz7xjfFIg"

Stripe.api_key = settings.secret_key


if ENV['DATABASE_URL']
  DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
else
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
end

class User
    include DataMapper::Resource
    property :id, Serial
    property :email, String
    property :password, String
    property :skills, Text
    property :full_name, Text
    property :preferred_location, Text
    property :pro, Boolean, :default => false
    property :administrator, Boolean, :default => false

    def login(password)
    	return self.password == password
    end
end

DataMapper.finalize

# automatically create the post table
User.auto_upgrade!
Listing.auto_upgrade!

#make an admin user if one doesn't exist!
if User.all(administrator: true).count == 0
	u = User.new
   u.full_name = "Admin"
	u.email = "admin@admin.com"
	u.password = "admin"
	u.administrator = true
	u.save
end

post "/charge" do
    authenticate!
    cu = current_user
    cu.pro = true
    cu.save

     # Amount in cents
  @amount = 500

  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Sinatra Charge',
    :currency    => 'usd',
    :customer    => customer.id
  )
  erb :account_profile
end


get "/user/upgrade" do
    authenticate!
 if (current_user.administrator == false && current_user.pro == false)
        erb :payform
    else
        redirect "/"
    end
end


get '/account/edit_profile' do
   authenticate!
   pro_only!
   erb :edit_profile
end

# Updates user account with name, skills, and preferred location
post '/update_profile' do
   if params["full_name"] && params["skills"]
      current_user.full_name = params["full_name"]
      current_user.skills = params["skills"]
      current_user.preferred_location = params["preferred_location"]
      current_user.save

      # Matching algorithm
      values = current_user.skills.split(',')
      alljobs = Listing.all
      alljobs.each do |v|
        v.count = 0
        internskill = v.skills.split(',')

        internskill.each do |i|
          values.each do |c|
            if (c.downcase == i.downcase)
              add = v.count.to_i+ 1
              v.count = add
            end
            v.save
          end
        end
      end
      erb :account_profile
  else
    return "Error! You're missing a parameter. "
  end
end


# GET request that displays a pro user's current profile
get '/profile' do
   authenticate!
   pro_only!
   erb :account_profile
end
