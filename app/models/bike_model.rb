class BikeModel < ActiveRecord::Base
  belongs_to :bike_brand
  
  attr_accessible :name, :brand_id
  	validates :brand_id, presence: true
	validates :bike_id, numericality: true
end
