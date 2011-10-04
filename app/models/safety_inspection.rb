class SafetyInspection < ActiveRecord::Base
  has_many :safety_item_responses
  belongs_to :inspector

end
