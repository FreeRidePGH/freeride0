class BikeModel < ActiveRecord::Base
  belongs_to :bike_brand
  has_many :bikes, :dependent => :destroy
  
  attr_accessible :name, :brand_id
  	
  validates :brand_id, :name, :presence => true
  validates_uniqueness_of :name, :scope => :brand_id, :message => "for the model already exists for its brand"

end
