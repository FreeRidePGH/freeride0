class Favorite < ActiveRecord::Base
	validates :user_id, :bike_id, :presence => true 
	validates_uniqueness_of :bike_id, :scope => :user_id, :message => "bike is already in favorite list"
end
