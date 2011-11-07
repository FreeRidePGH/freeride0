class Favorite < ActiveRecord::Base
	validates :user_id, :bike_id, :presence => true 
end
