class Tweet < ActiveRecord::Base
  has_many :mentions
  has_many :likes
  has_many :replies
  belongs_to :users

  def author
  	return username
  end 

end
