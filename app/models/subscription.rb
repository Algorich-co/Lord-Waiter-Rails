class Subscription < ApplicationRecord
  belongs_to :restaurant_owner
  validates :restaurant_owner, presence: true
end
