class User < ActiveRecord::Base
  has_many :eab_projects
  has_many :repair_hours_entries
  has_many :volunteer_hours_entries
  
  attr_accessor :password
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation                
  attr_protected :account_value, :has_read_packet, :role
  
end
