class Payment < ApplicationRecord
	
  belongs_to :restaurant_owner
  validates :restaurant_owner, :price, :locale, presence: true

end
