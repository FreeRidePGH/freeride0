class SafetyInspection < ActiveRecord::Base
  has_many :safety_item_responses
  belongs_to :inspector, :class_name => "User"
  belongs_to :bike
  
  accepts_nested_attributes_for :safety_item_responses
  
  attr_accessible :bike_id, :inspector_id, :inspection_date, :safety_item_responses_attributes
  
  validates :inspector_id, :presence => true
  validates :bike_id, :presence => true
  
  scope :all, :order => "inspection_date DESC, created_at DESC"

  def result_text
    self.safety_item_responses.each do |response|
      if !response.is_checked
        return "Failed"
      end
    end
    "Passed!"
  end
  
  def date_text
    return inspection_date.localtime.strftime("%A %-m/%-e/%Y")
  end
  
end
