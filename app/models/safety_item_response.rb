class SafetyItemResponse < ActiveRecord::Base
  belongs_to :safety_item
  belongs_to :safety_inspection
  
  attr_accessible :safety_inspection_id, :safety_item_id, :is_checked
  
end
