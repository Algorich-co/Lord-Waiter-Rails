class CreateWaiterCalls < ActiveRecord::Migration[5.0]
  def change
    create_table :waiter_calls do |t|
      t.references :table, foreign_key: true
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
