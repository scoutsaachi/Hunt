class Scavenger < ActiveRecord::Base
	belongs_to :user
	has_many :tasks
	has_many :teams
end
