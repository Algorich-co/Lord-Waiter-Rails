class AddCheckedoutToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :checked_out_at, :datetime
  end
end
