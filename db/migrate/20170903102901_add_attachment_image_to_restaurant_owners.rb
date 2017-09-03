class AddAttachmentImageToRestaurantOwners < ActiveRecord::Migration
  def self.up
    change_table :restaurant_owners do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :restaurant_owners, :image
  end
end
