class BikeBrand < ActiveRecord::Base
  has_many :bike_models, :dependent => :destroy
  has_many :bikes, :dependent => :destroy
  
  attr_accessible :name
  
  validates :name, :presence => true
	validates :name, :uniqueness => true
end
