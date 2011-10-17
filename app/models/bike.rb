class Bike < ActiveRecord::Base
  has_one :eab_project
  has_one :bike_brand
  has_one :bike_model
  has_one :location
  
  attr_accessible :model_id, :brand_id, :location_id, :wheel_size, :frame_size, 
                  :top_tube, :seat_tube, :color, :type
  
  
end
