class AddTaxToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :tax, :decimal, :default => 0
    add_column :restaurants, :tax_available, :boolean, :default => false
  end
end
