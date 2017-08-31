class CreateClients < ActiveRecord::Migration[5.0]
	def change
		create_table :clients do |t|
			t.string   "email"
			t.string   "password_hash"
			t.string   "password_salt"
			t.string   "name"
			t.string   "belongs_to"
			t.datetime "created_at",                        null: false
			t.datetime "updated_at",                        null: false
			t.string   "authentication_token", default: ""
			t.float    "latitude"
			t.float    "longitude"
			t.index ["authentication_token"], name: "index_clients_on_authentication_token", unique: true, using: :btree
		end
	end
end
