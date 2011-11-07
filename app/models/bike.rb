class Bike < ActiveRecord::Base
  has_one :eab_project
  has_one :bike_brand
  has_one :bike_model
  has_one :location
  
  attr_accessible :model_id, :brand_id, :location_id, :wheel_size, :frame_size, 
                  :top_tube, :seat_tube, :color, :status, :date_in, :date_out
  
  validates :brand_id, :presence => true 
  validates_numericality_of :model_id, :brand_id, :message => "has to be selected"

end
