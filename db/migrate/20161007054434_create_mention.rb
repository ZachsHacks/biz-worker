class CreateMention < ActiveRecord::Migration
  def change
    create_table :mentions do |m|
      m.integer :tweet_id
      m.integer :author_id
      m.integer :mentioned_id
    end
  end
end
