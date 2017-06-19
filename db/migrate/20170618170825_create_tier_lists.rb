class CreateTierLists < ActiveRecord::Migration[5.0]
  def change
    create_table :tier_lists do |t|
      # t.references :user
      t.string :name
      t.integer :list_type
      t.text :description
      t.integer :upvotes, default: 0

      t.timestamps
    end
  end
end
