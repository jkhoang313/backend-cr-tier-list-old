class CreateTiers < ActiveRecord::Migration[5.0]
  def change
    create_table :tiers do |t|
      t.string :title
      t.text :description
      t.text :notes
      t.jsonb :cards
      
      t.timestamps
    end
  end
end
