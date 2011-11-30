class EabProject < ActiveRecord::Base
  belongs_to :bike
  belongs_to :user
  has_many :repair_hours_entries
  
  attr_accessible :bike_id, :user_id, :status, :start_date
  
  validates :bike_id, :presence => true
  validates :user_id, :presence => true
  
  #scope :all, :order => "status"
  
  def start_date_format
    return start_date.localtime.strftime("%a, %-m/%-e/%Y %-I:%M %p") # show the year
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

  def stickerID
	return Bike.find_by_id(self.bike_id).bike_id
  end
end