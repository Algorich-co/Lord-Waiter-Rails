class AddNameToTable < ActiveRecord::Migration[5.0]
  def change
    add_column :tables, :name, :string
  end
end
