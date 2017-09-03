class RestaurantOwner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
	  :recoverable, :rememberable, :trackable, :validatable,
	  :confirmable, :lockable

  validates :full_name, presence: true, length: { minimum: 4, maximum: 35 }
  validates :contact, presence: true, length: { minimum: 4, maximum: 16 }


  has_attached_file :image, styles: { medium: "500x500>", thumb: "100x100>" }, default_url: "/assets/:style/restaurant_owner.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_presence_of :full_name
  validates_presence_of :contact

  def image_url
  	image.url(:medium)
  end

end
