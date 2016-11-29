class CreateTweetsHashtags < ActiveRecord::Migration
  def change
    create_table :tweets_hashtags do |th|
      th.integer :tweet_id
      th.integer :hashtag_id
    end
  end
end
