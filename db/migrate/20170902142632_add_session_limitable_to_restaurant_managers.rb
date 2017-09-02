class AddSessionLimitableToRestaurantManagers < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurant_managers, :unique_session_id, :string, limit: 20
  end
end
