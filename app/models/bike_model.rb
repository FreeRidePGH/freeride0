class BikeModel < ActiveRecord::Base
  belongs_to :brand, :class_name => "BikeBrand"
  has_many :bikes, :dependent => :destroy
  
  attr_accessible :name, :brand_id
  	
  validates :brand_id, :name, :presence => true
  validates_uniqueness_of :name, :scope => :brand_id, :message => "This model already exists for the brand."

end
