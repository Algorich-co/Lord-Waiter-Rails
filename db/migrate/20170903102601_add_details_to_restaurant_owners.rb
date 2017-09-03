class AddDetailsToRestaurantOwners < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurant_owners, :full_name, :string
    add_column :restaurant_owners, :contact, :string
  end
end
