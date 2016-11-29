class CreateFollow < ActiveRecord::Migration
  def change
    create_table :follows do |f|
      f.integer :er_id
      f.integer :ing_id
    end
  end
end
