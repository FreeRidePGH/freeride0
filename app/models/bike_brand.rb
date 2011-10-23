class BikeBrand < ActiveRecord::Base
  has_many :bike_models
  has_many :bikes
  
  attr_accessible :name
  
  validates :name, :presence => true
	validates :name, :uniqueness => true
end
