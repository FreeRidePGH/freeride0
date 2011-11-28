class Favorite < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :bike
  
	validates :user_id, :bike_id, :presence => true 
	validates_uniqueness_of :bike_id, :scope => :user_id, :message => "Bike is already in favorites list."
	
  def self.hasBike(userid, bikeid)
	favlist = Favorite.where(:user_id => userid)
	for i in favlist
		if i.bike_id == bikeid
			return false
		end
	end
	return true
  end
	
end
