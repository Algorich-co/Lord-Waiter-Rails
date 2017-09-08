class AddLocaleToRestaurantOwners < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurant_owners, :locale, :string, default: 'pk'
  end
end
