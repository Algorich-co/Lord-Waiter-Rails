class AddActiveToRestaurantOwner < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurant_owners, :active, :boolean, :default => false, :null => false
  end
end
