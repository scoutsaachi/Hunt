class User < ActiveRecord::Base
	has_many :photos
	has_many :comments
	has_many :scavengers
	has_and_belongs_to_many :teams
end
