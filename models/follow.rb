class Follow < ActiveRecord::Base
  validate :cannot_follow_self

  def cannot_follow_self
    errors.add(:er_id, 'You cannot follow yourself.') if er_id == ing_id
  end
end
