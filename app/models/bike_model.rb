class BikeModel < ActiveRecord::Base
  belongs_to :bike_brand
  
  attr_accessible :name, :brand_id
  	
  validates :brand_id, :name, :presence => true
	validates :name, :uniqueness => true
end
