require 'faker'
require './helpers/helper_methods'
require 'csv'

def create_users
	columns = [:username, :email, :first_name, :last_name, :img_url, :dob, :password, :password_digest, :bio]
	values=[]
	CSV.foreach("./db/seeds/users.csv") do |row|
		username = row[1]
		img_url = "a"
		pa = Faker::Internet.password
		password = pa
		password_digest = pa+"a"
		f_n = Faker::Name.first_name
		email = Faker::Internet.safe_email(f_n)
		first_name = f_n
		last_name = Faker::Name.last_name
		dob = "2016-10-15"
		bio = Faker::Lorem.paragraph(2, false, 4)
		a=[username, email, first_name, last_name, img_url, dob, password, password_digest, bio]
		values<<a
	end
	User.import columns, values
end

def create_tweets
	columns = [:user_id, :username, :time, :body]
	values = []
	name = []
	CSV.foreach("./db/seeds/tweets.csv") do |row|
		user = row[0].to_i
		if !name[user-1].nil?
			username = name[user-1]
		else
			username = User.find(user).username
			name[user-1]=username
		end
		time = row[2]
		content = row[1]
		a = [user, username, time, content]
		values<<a
	end
	Tweet.import columns, values
end

def create_follows
	columns = [:er_id, :ing_id]
	values = []
	CSV.foreach("./db/seeds/follows.csv") do |row|
		er = row[0]
		ing = row[1]
		a = [er, ing]
		values<<a
	end
	Follow.import columns, values
end

burn_down_the_house
create_users
create_tweets
create_follows
