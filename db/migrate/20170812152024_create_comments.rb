class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :tier_list
      t.references :parent_comment
      t.references :user
      t.integer :upvotes, default: 0
      t.text :message

      t.timestamps
    end
  end
end
