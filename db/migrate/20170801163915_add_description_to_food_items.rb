class AddDescriptionToFoodItems < ActiveRecord::Migration[5.0]
  def change
    add_column :food_items, :description, :text, :default => ""
  end
end
