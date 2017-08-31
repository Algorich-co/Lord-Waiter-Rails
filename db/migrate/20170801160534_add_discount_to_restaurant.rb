class AddDiscountToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :discount, :decimal, :default => 0
    add_column :restaurants, :discount_available, :boolean, :default => false
  end
end
