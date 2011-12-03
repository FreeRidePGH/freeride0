class EabProject < ActiveRecord::Base
  belongs_to :bike
  belongs_to :user
  has_many :repair_hours_entries, :order => "start_time DESC"
  has_many :latest_repair_hours_entries, :class_name => "RepairHoursEntry", :order => "start_time DESC", :limit => 1

  attr_accessible :bike_id, :user_id, :status, :start_date

  validates :bike_id, :presence => true
  validates :user_id, :presence => true

  #scope :all, :order => "status"

  def start_date_format
    return start_date.localtime.strftime("%a, %-m/%-e/%Y %-I:%M %p") # show the year
  end

  def last_active
    latest_entry = self.latest_repair_hours_entries
    if !latest_entry.empty? && latest_entry.first.created_at > self.updated_at
      return latest_entry.first.created_at
    end
    self.updated_at
  end

  def statusName
    eabStatusList = Hash.new	
    eabStatusList = {
      100 => "EAB in progress",
      200 => "Ready for Inspection",
      300 => "Inspection passed",
      325 => "Inspection failed",
      350 => "Inspection expired",
      375 => "Bike earned", #(cash, hours or combination) 
      400 => "Bike signed off", #(Project Completed) 
      500 => "Inactive",
      600 => "Abandoned"
    }  
    return eabStatusList[self.status]
  end

  def self.statusList
    eabStatusList = Hash.new	
    eabStatusList = {
      100 => "EAB in progress",
      200 => "Ready for Inspection",
      300 => "Inspection passed",
      325 => "Inspection failed",
      350 => "Inspection expired",
      375 => "Bike earned", #(cash, hours or combination) 
      400 => "Bike signed off", #(Project Completed) 
      500 => "Inactive",
      600 => "Abandoned"
    }  
    return eabStatusList
  end
  
  def value
    assessment = self.bike.bike_assesment
		value = assessment.value unless assessment.nil?
		value = 0 if value.nil?
		return value
  end
  
  def prereqs_complete?
    return self.user.has_read_packet 
  end
  
  def value_earned?
		return true if self.user.account_value >= self.value
		false
  end
  
  def safety_check_complete?
    return self.bike.has_passed_safety?
  end
  
  def ready_to_sign_off?
    return false unless prereqs_complete?
    return false unless value_earned?
    return false unless safety_check_complete?
    return false if status >= 400
    true
  end
  
  def signed_off?
    return true if self.status == 400
    false
  end
  
end