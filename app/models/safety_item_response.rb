class SafetyItemResponse < ActiveRecord::Base
  belongs_to :safety_item
  belongs_to :safety_inspection
end
