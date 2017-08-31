class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.references :order, foreign_key: true
      t.references :food_item, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
