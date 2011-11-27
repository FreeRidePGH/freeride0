class Transaction < ActiveRecord::Base
  
  after_save :update_account_value
  before_destroy :update_account_value_destroy
  
  belongs_to :user
  
  attr_accessible :user_id, :amount
  
  scope :all, :order => "created_at DESC"
  
  validates :amount, :presence => true, :numericality => true
  validates :user_id, :presence => true
  
  def created_at_format
    return created_at.localtime.strftime("%-m-%-e-%Y %-I:%M %p")
  end
  
  private
    def update_account_value
      self.user.account_value = self.user.account_value + self.amount
      self.user.save
    end
    
    def update_account_value_destroy
      self.user.account_value = self.user.account_value - self.amount
      self.user.save
    end
  
end
