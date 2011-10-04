class EabProject < ActiveRecord::Base
  has_one :bike
  has_one :user
  
  attr_accessible :bike_id, :user_id, :status, :start_date
  
end
