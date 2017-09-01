class Restaurant < ApplicationRecord
	has_one :restaurant_manager
	has_many :food_items
  has_many :categories
  has_many :tables
  has_many :orders
  has_attached_file :image, styles: { medium: "500x500>", thumb: "100x100>" }, default_url: "/assets/:style/restaurant.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :contact
  validates_presence_of :image

  validates :discount, :length => { :minimum   => 0, :maximum   => 100 }
  validates :tax, :length => { :minimum   => 0, :maximum   => 100 }
  validates :name, :length => { :minimum   => 3, :maximum   => 50 }
  validates :address, :length => { :minimum   => 3, :maximum   => 250 }
  validates :contact, :length => { :minimum   => 3, :maximum   => 20 }

  def image_url
    image.url(:medium)
  end

end
