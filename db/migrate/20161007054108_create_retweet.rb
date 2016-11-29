class CreateRetweet < ActiveRecord::Migration
  def change
    create_table :retweets do |r|
      r.integer :tweet_id
      r.integer :retweeter_id
    end
  end
end
