class AddActiveToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :active, :boolean, :default => false
  end
end
