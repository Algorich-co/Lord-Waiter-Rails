class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :table, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.boolean :delivered
      t.boolean :paid
      t.decimal :total_price, :precision => 8, :scale => 2, :default => 0.0

      t.timestamps
    end
  end
end
