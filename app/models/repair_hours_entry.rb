class RepairHoursEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :bike
  belongs_to :eab_project
  
  attr_accessible :user_id, :bike_id, :start_time, :end_time, :eab_project_id, :description
  
  validates :user_id, :presence => true
  validates :bike_id, :presence => true
  validates :eab_project_id, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true
  
  
  def start_date
    return start_time.localtime.strftime("%A %-m/%-e/%Y")
  end
  def end_date
  return end_time.localtime.strftime("%A %-m/%-e/%Y")
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
  
  def f_start_time
    return start_time.localtime.strftime("%I:%M %p")
  end
  def f_end_time
    return end_time.localtime.strftime("%I:%M %p")
  end
end
