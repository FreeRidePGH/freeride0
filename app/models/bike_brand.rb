class BikeBrand < ActiveRecord::Base
  has_many :bike_models
  has_many :bikes
  
end
