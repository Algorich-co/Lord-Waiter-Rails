class AddNameToRestaurantManager < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurant_managers, :name, :string
  end
end
