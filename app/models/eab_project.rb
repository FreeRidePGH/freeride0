class EabProject < ActiveRecord::Base
  belongs_to :bike
  belongs_to :user
  has_many :repair_hours_entries
  
  attr_accessible :bike_id, :user_id, :status, :start_date
  
  validates :bike_id, :presence => true
  validates :user_id, :presence => true
  
  def start_date_format
    return start_date.localtime.strftime("%a, %-m/%-e/%Y %-I:%M %p") # show the year
  end
  
end
