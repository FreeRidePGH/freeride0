class Bike < ActiveRecord::Base
  has_one :eab_project
  has_one :bike_brand
  has_one :bike_model
  has_one :location
  has_many :safety_inspections, :order => "inspection_date DESC, created_at DESC"
  
  attr_accessible :model_id, :brand_id, :location_id, :wheel_size, :frame_size, 
                  :top_tube, :seat_tube, :color, :status, :date_in, :date_out, :bike_id
  
  validates_presence_of :bike_id, :message => "ID cannot be blank"
  validates_numericality_of :bike_id, :message =>"ID is invalid"
  validates :brand_id, :presence => true 
  validates_numericality_of :brand_id,  :message => "has to be selected"
  validates_numericality_of :model_id, :message => "is invalid"
  validates_uniqueness_of :bike_id, :message => "ID has already been taken"
  
  def self.search(search)
    if search
      where('bike_id LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  def has_passed_safety?
    return false if self.safety_inspections.empty?
    self.safety_inspections[0].passed?
  end

end
