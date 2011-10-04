class VolunteerHoursEntry < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :user_id, :start_time, :end_time
  
end
