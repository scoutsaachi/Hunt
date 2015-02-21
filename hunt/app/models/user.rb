class User < ActiveRecord::Base
	has_many :photos
	has_many :comments
	has_many :scavengers
	has_and_belongs_to_many :teams
	validates :user_name, presence: true
	validates :login, presence: true
	validates :password, confirmation: true
	validates :password_confirmation, presence: true
	validates_uniqueness_of :login 

	def password
		@password
	end

	# Method: password=
	# Purpose: Given a typed password, set the salt for the user, compute the password digest
	# and set the virtual attribute password
	# Parameters: newpassword(string) the new password for this user
	def password=(newpassword)
		self.salt = Random.rand
		self.password_digest = Digest::SHA1.hexdigest(newpassword + self.salt.to_s)
		@password = newpassword
	end

	# Method: password_valid?
	# Purpose: given a candidate password, compute the password digest and return whether it is the valid password
	def password_valid?(candidate)
		return Digest::SHA1.hexdigest(candidate + self.salt.to_s)==password_digest
	end
end
