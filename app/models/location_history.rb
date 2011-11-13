class LocationHistory < ActiveRecord::Base
	has_one:bike
	
  validates :bike_id, :presence => true 	
				  
end
