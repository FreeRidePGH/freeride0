class VolunteerHoursEntry < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :user_id, :start_time, :end_time
  
  def date
    return start_time.localtime.strftime("%A %-m/%-e/%Y")
  end
  
end
