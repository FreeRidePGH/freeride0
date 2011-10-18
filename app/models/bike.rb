class Bike < ActiveRecord::Base
  has_one :eab_project
  has_one :bike_brand
  has_one :bike_model
  has_one :location
  
  attr_accessible :model_id, :brand_id, :location_id, :wheel_size, :frame_size, 
                  :top_tube, :seat_tube, :color, :quality, :condition, :status, :date_in, :date_out, :bike_id
  
  	validates :model_id, :brand_id, :bike_id, presence: true
	validates :brand_id, :bike_id, numericality: true
	validates :bike_id, uniqueness: true
end
