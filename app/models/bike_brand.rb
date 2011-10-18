class BikeBrand < ActiveRecord::Base
  has_many :bike_models
  has_many :bikes
  
  attr_accessible :name, :brand_id
  	validates :name, :brand_id, presence: true
	validates :name, :brand_id, uniqueness: true
end
