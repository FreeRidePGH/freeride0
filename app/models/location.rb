class Location < ActiveRecord::Base
  has_many :bikes
  
  attr_accessible :name, :description, :hook_number
  
end
