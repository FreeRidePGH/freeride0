class RepairHoursEntry < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :user_id, :bike_id, :start_time, :end_time
  
end
