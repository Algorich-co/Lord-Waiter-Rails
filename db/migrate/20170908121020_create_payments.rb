class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :restaurant_owner, foreign_key: true
      t.decimal :price
      t.string :locale

      t.timestamps
    end
  end
end
