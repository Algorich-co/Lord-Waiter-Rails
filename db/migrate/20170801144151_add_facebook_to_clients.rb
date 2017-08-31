class AddFacebookToClients < ActiveRecord::Migration[5.0]
  def change
  	add_column :clients, :connected_with_facebook, :boolean, :default => false
    add_column :clients, :facebook_id, :string
    add_column :clients, :facebook_token, :text
  end
end