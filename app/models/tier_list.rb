class TierList < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  def change_upvotes(number)
    self.update(upvotes: upvotes + number)
  end
end
