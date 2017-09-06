class RemoveRestaurantFromCategory < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :categories, :restaurant, foreign_key: true
  end
end
