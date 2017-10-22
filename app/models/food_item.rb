class FoodItem < ApplicationRecord
  belongs_to :category
  belongs_to :restaurant
  has_attached_file :image, styles: { medium: "500x500>", thumb: "100x100>" }, default_url: "/assets/:style/food_item.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_presence_of :title, length: { in: 6..30 }
  validates_presence_of :price, :length => { :minimum   => 0 }
  validates_presence_of :category
  validates_presence_of :restaurant
  validates :description, length: { in: 0..250 }
  # validates_presence_of :image

  def image_url
    image.url(:medium)
  end 

  def image_url_thumb
    image.url(:thumb)
  end

end