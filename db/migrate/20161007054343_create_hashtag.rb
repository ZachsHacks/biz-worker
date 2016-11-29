class CreateHashtag < ActiveRecord::Migration
  def change
    create_table :hashtags do |h|
      h.string :word
    end
  end
end
