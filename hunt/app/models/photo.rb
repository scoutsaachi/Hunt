class Photo < ActiveRecord::Base
	has_many :comments
	belongs_to :user
	belongs_to :task
	belongs_to :team
end
