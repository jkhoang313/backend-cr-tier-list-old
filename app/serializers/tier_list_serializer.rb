class TierListSerializer < ActiveModel::Serializer
  attributes :id, :name, :list_type, :description, :upvotes
end
