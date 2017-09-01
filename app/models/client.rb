class Client < ApplicationRecord

	attr_accessor :password
	before_save :encrypt_password
	before_create :generate_authentication_token

	has_many :orders
	has_many :waiter_calls

	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :name, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email
	validates_uniqueness_of :authentication_token

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
	format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }

	def self.authenticate(email, password)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	def generate_authentication_token
		loop do
			self.authentication_token = SecureRandom.base64(64)
			break unless Client.find_by(authentication_token: authentication_token)
		end
	end

end
