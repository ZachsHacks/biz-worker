#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
require 'zlib'
require 'byebug'
configure :production, :development do
	# ENV['DATABASE_URL'] = 'postgres://prndwaruyimvgf:WgBPm2U7wAjVnOlmoQMQvVmmqw@ec2-54-235-111-109.compute-1.amazonaws.com:5432/d5b2bucverfmu6'
	db = URI.parse(ENV['DATABASE_URL']) #|| 'postgres://localhost/mydb')

	ActiveRecord::Base.establish_connection(
			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:host     => db.host,
			:username => db.user,
			:password => db.password,
			:database => db.path[1..-1],
			:encoding => 'utf8'
	)
end
