class Bike < ActiveRecord::Base
  has_one :eab_project
  has_one :bike_brand
  has_one :bike_model
  has_one :location
  has_many :safety_inspections
  
  attr_accessible :model_id, :brand_id, :location_id, :wheel_size, :frame_size, 
                  :top_tube, :seat_tube, :color, :status, :date_in, :date_out, :bike_id
  
  validates :brand_id, :bike_id, :presence => true 
  validates_numericality_of :model_id, :brand_id, :bike_id, :message => "has to be selected"
  validates_uniqueness_of :bike_id, :message => "ID has already been taken"
  
  def self.search(search)
    if search
      where('bike_id LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
