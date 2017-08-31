class AddRestaurantToRestaurantManager < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurant_managers, :restaurant, foreign_key: true
  end
end
