class CreateReply < ActiveRecord::Migration
  def change
    create_table :replies do |r|
      r.integer :source_id
      r.integer :target_id
    end
  end
end
