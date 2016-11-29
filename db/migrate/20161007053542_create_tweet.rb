class CreateTweet < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.string :username
      t.string :body
      t.datetime :time
    end
  end
end
