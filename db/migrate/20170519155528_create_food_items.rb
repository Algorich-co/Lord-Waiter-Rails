class CreateFoodItems < ActiveRecord::Migration[5.0]
  def change
    create_table :food_items do |t|
      t.string :title
      t.decimal :price
      t.boolean :featured,:default => false
      t.references :category, foreign_key: true
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
