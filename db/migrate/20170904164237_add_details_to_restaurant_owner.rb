class AddDetailsToRestaurantOwner < ActiveRecord::Migration[5.0]
  def change
  	remove_column :restaurants, :tax, :decimal, :default => 0
    remove_column :restaurants, :tax_available, :boolean, :default => false
    remove_column :restaurants, :discount, :decimal, :default => 0
    remove_column :restaurants, :discount_available, :boolean, :default => false
    add_column :restaurant_owners, :tax, :decimal, :default => 0
    add_column :restaurant_owners, :tax_available, :boolean, :default => false
    add_column :restaurant_owners, :discount, :decimal, :default => 0
    add_column :restaurant_owners, :discount_available, :boolean, :default => false
  end
end
