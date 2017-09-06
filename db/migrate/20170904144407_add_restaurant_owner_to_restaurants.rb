class AddRestaurantOwnerToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurants, :restaurant_owner, foreign_key: true
  end
end
