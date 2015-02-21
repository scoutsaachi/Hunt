class Task < ActiveRecord::Base
	has_many :photos
	belongs_to :scavenger
end
