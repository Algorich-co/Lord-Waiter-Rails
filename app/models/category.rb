class Category < ApplicationRecord
	has_many :food_items
	has_attached_file :image, styles: { medium: "500x500>", thumb: "150x150>" }, default_url: "/assets/:style/category.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	validates_presence_of :name, length: { in: 6..20 }
	# validates_presence_of :image

	validates :name, :length => { :minimum   => 2, :maximum   => 50 }




	def image_url
		image.url(:medium)
	end

	def image_url_thumb
    	image.url(:thumb)
  	end

end