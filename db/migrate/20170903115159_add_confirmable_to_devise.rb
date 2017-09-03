class AddConfirmableToDevise < ActiveRecord::Migration
  # Note: You can't use change, as RestaurantOwner.update_all will fail in the down migration
  def up
    add_column :restaurant_owners, :confirmation_token, :string
    add_column :restaurant_owners, :confirmed_at, :datetime
    add_column :restaurant_owners, :confirmation_sent_at, :datetime
    add_column :restaurant_owners, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :restaurant_owners, :confirmation_token, unique: true
    # RestaurantOwner.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # restaurant_owners as confirmed, do the following
    RestaurantOwner.all.update_all confirmed_at: DateTime.now
    # All existing restaurant_owner accounts should be able to log in after this.
  end

  def down
    remove_columns :restaurant_owners, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :restaurant_owners, :unconfirmed_email # Only if using reconfirmable
  end
end