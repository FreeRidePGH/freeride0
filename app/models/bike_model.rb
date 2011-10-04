class BikeModel < ActiveRecord::Base
  belongs_to :bike_brand
  
  attr_accessible :name, :brand_id
  
end
