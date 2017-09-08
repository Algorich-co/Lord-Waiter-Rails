class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :restaurant_owner, foreign_key: true
      t.integer :number_of_branches, default: 1, null: false
      t.integer :number_of_managers, default: 1, null: false
      t.integer :managers_per_branch, default: 1, null: false
      t.datetime :last_payment
      t.datetime :valid_till

      t.timestamps
    end
  end
end
