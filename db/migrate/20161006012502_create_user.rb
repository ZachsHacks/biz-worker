class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :username
      u.string :email
      u.string :first_name
      u.string :last_name
      u.string :img_url
      u.date :dob
      u.string :password
      u.string :password_digest
      u.string :bio
    end
    add_index :users, :username, unique: true
  end
end
