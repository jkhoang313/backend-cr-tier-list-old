class TierList < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  def change_upvotes(number)
    self.update(upvotes: upvotes + number)
  end

  def update_card_position(card, tier_index, position)
    self.remove_card_from_tiers(card)
    self.insert_card_into_tier(card, tier_index, position)
  end

  def remove_card_from_tiers(card)
    new_tier_positions = self.tier_positions.map do |tier|
      new_tier = tier
      new_tier["cards"] = tier["cards"] - [card]
      new_tier
    end

    self.update(tier_positions: new_tier_positions)
  end

  def insert_card_into_tier(card, tier_index, position)
    tier_to_add = self.tier_positions[tier_index]
    tier_to_add["cards"].insert(position, card)
    self.tier_positions[tier_index] = tier_to_add
    self.save
  end

  def update_tier_details(update_params)
    updated_tier_positions = self.tier_positions

    update_params.each do |key, value|
      if key.starts_with?("tier")
        index = key.split('-').last.to_i
        tier_to_change = updated_tier_positions[index]
        changes = update_params[key]
        tier_to_change["name"] = changes["name"]
        tier_to_change["description"] = changes["description"]
        updated_tier_positions[index] = tier_to_change
      end
    end
    
    self.update(tier_positions: updated_tier_positions)
  end
end
