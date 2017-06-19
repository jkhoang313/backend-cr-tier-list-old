class TierList < ApplicationRecord
  has_many :tiers

  def change_upvotes(number)
    self.update(upvotes: upvotes + number)
  end
end
