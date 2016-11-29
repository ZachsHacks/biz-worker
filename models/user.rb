require 'bcrypt'
require 'yaml'

class User < ActiveRecord::Base
	has_many :tweets
	has_many :mentions
	has_many :hashtags
	has_many :likes

	has_secure_password

	attr_reader :name

	def timeline
		followings_ids=Follow.where(er_id: self.id).pluck(:ing_id)
		followings_ids<<self.id
		return Tweet.where(user_id: followings_ids).last(20).reverse
	end

	def user_timeline # ONLY the tweets that a user wrote or is mentioned in
		return Tweet.where(user_id: self.id).take(20)
	end

end
