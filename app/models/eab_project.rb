class EabProject < ActiveRecord::Base
  has_one :bike
  has_one :user
end
