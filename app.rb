require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
      #Model class

get '/' do
	"HELLO WORLD"
end
