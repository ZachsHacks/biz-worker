class Hashtag < ActiveRecord::Base

	def initialize(text, tweet_id, user_id)
		@tweet = tweet_id
		@user = user_id
		@text = text 
	end 

	def getTweetId
		# do we need to do validation here? 
		# are we creating it with the id or the entire tweet
		@tweet
	end 

	def getUser
		@user
	end 

	def getText
		@text
	end 
	
end
