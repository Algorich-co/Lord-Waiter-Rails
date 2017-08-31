class AddClientToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :client, foreign_key: true
  end
end
