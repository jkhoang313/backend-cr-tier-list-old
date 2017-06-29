class TierListSerializer < ActiveModel::Serializer
  has_one :creator
  attributes :id, :name, :list_type, :description, :upvotes, :tiers

  def tiers
    object.tier_positions
  end
end
