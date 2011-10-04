class SafetyInspection < ActiveRecord::Base
  has_many :safety_item_responses
  belongs_to :inspector
  
  attr_accessible :bike_id, :inspector_id, :inspection_date

end
