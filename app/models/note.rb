class Note < ActiveRecord::Base
	validates_presence_of :bike_id, :user_id, :title
end
