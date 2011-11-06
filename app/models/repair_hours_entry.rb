class RepairHoursEntry < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :user_id, :bike_id, :start_time, :end_time
  
  def start_date
    return start_time.localtime.strftime("%A %-m/%-e/%Y")
  end
  def end_date
    return start_time.localtime.strftime("%A %-m/%-e/%Y")
  end
  
  def duration
    #returns the duration in hours
    return (end_time - start_time)/60.0/60.0
  end
  
  def duration_text
    duration_min = ((end_time - start_time)/60.0).round
    if duration_min < 60
      return "#{duration_min} minutes"
    elsif duration_min % 60 == 0
      return "#{duration_min/60} hours"
    else
      return "#{duration_min/60} hours, #{duration_min%60} minutes"
    end
  end
  
end
