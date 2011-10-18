class BikeModel < ActiveRecord::Base
  belongs_to :bike_brand
  
  attr_accessible :name, :brand_id, :model_id
  	validates :brand_id, :model_id, presence: true
	validates :bike_id, numericality: true
	validates :name, :model_id, uniqueness: true
end
