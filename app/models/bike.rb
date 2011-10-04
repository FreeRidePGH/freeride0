class Bike < ActiveRecord::Base
  has_and_belongs_to_many :eab_projects
  has_one :bike_brand
  has_one :bike_model
  has_one :location
  
end
