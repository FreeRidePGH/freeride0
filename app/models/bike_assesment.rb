class BikeAssesment < ActiveRecord::Base
  validates :bike_id, :presence => true 
end
