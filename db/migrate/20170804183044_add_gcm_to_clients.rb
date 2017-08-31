class AddGcmToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :gcm, :text
  end
end
