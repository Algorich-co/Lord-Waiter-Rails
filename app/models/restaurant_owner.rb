class RestaurantOwner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :lockable

  validates :full_name, presence: true, length: { minimum: 4, maximum: 35 }
  validates :contact, presence: true, length: { minimum: 4, maximum: 16 }

  validates :email, presence: true


  has_attached_file :image, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/assets/:style/restaurant_owner.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_presence_of :full_name
  validates_presence_of :contact


  validates :discount, :length => { :minimum   => 0, :maximum   => 100 }
  validates :tax, :length => { :minimum   => 0, :maximum   => 100 }

  has_many :restaurants
  has_many :food_items, :through => :restaurants
  has_many :restaurant_managers, :through => :restaurants
  has_many :tables, :through => :restaurants
  has_many :orders, :through => :restaurants
  has_many :payments
  has_one :subscription


  def image_url
    image.url(:medium)
  end

  def image_url_thumb
    image.url(:thumb)
  end

end