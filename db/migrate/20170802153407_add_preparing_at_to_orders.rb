class AddPreparingAtToOrders < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :preparing_at, :datetime
  	add_column :orders, :served_at, :datetime
  end
end
