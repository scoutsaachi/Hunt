class Team < ActiveRecord::Base
	belongs_to :scavenger
	has_and_belongs_to_many :users
	has_many :photos
end
