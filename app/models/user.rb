class User < ActiveRecord::Base
  has_many :eab_projects
  has_many :repair_hours_entries
  has_many :volunteer_hours_entries
  
end
