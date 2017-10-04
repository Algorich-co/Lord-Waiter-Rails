class Restaurant < ApplicationRecord
  belongs_to :restaurant_owner
	has_one :restaurant_manager
	has_many :food_items
  has_many :tables
  has_many :orders
  has_attached_file :image, styles: { medium: "500x500>", thumb: "150x150>" }, default_url: "/assets/:style/restaurant.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :contact
  validates_presence_of :image
  validates_presence_of :restaurant_owner

  validates :name, :length => { :minimum   => 3, :maximum   => 50 }
  validates :address, :length => { :minimum   => 3, :maximum   => 250 }
  validates :contact, :length => { :minimum   => 3, :maximum   => 20 }

  def image_url
    image.url(:medium)
  end

  def image_url_thumb
    image.url(:thumb)
  end

end
