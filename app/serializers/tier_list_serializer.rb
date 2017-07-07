class TierListSerializer < ActiveModel::Serializer
  has_one :creator
  attributes :id, :title, :list_type, :description, :upvotes, :tiers, :created_at, :updated_at

  def tiers
    object.tier_positions
  end

  def created_at
    object.created_at.strftime("%-m-%-d-%Y")
  end

  def updated_at
    object.updated_at.strftime("%-m-%-d-%Y")
  end
end
