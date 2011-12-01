class LocationHistory < ActiveRecord::Base
	belongs_to :bike
	
  validates :bike_id, :presence => true 	
				  
end
