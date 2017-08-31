class AddRestaurantToCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :categories, :restaurant, foreign_key: true
  end
end
