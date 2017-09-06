class Category < ApplicationRecord
	has_many :food_items
	has_attached_file :image, styles: { medium: "500x500>", thumb: "100x100>" }, default_url: "/assets/:style/category.jpg"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	validates_presence_of :name, length: { in: 6..20 }
	validates_presence_of :image
	validates_presence_of :restaurant

	validates :name, :length => { :minimum   => 2, :maximum   => 50 }




	def image_url
		image.url(:medium)
	end

end
