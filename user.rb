require 'data_mapper' # metagem, requires common plugins too.
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

  erb :charge

  "Success!"
end


get "/user/upgrade" do
    authenticate!
 if (current_user.administrator == false && current_user.pro == false)
        erb :payform
    else
        redirect "/"
    end
end 
