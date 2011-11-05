require 'digest'

class User < ActiveRecord::Base
  has_many :eab_projects
  has_many :repair_hours_entries
  has_many :volunteer_hours_entries
  
  attr_accessor :password # using attr_accessor :password creates a virtual password attribute, not stored in database
  attr_accessor :phone1, :phone2, :phone3
  attr_accessible :first_name, :last_name, :email, :phone_number, :can_text_phone, :address, :password, :password_confirmation             
  attr_protected :account_value, :has_read_packet, :role
  
  validates :password, :presence => true,
                       :confirmation => true, # auto creates virtual attribute :password_confirmation
                       :length => { :within => 5..40 },
                       :if => :password_required? # don't validate password if not creating/changing it
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => { :with => /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]*\.[a-zA-Z0-9]{2,}$/ }
                      
  scope :search, lambda { |term| where("users.first_name LIKE ? OR users.last_name LIKE ? OR users.email LIKE ?", "%#{term}%", "%#{term}%", "%#{term}%")}

  # only encrypt the password to be stored if it is being created or changed
  before_save :encrypt_password, :if => :password_required?
  before_save :sanitize_user
  before_update :sanitize_user
  before_create :initialize_user
  
  # Return true if the user's password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  # Returns the User if the email matches the password, otherwise
  # returns nil if either the password doesn't match or the email
  # isn't found in the database
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil? # return nil if can't find email in database
    
    # return user if the password is correct
    return user if user.has_password?(submitted_password)
    
    nil # return nil if password doesn't match
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def name
    first_name + " " + last_name
  end
  



  protected
  
    # used to skip password validation, unless the User doesn't have
    # an encrypted password stored in the db (meaning a new user) or
    # the User has entered a new password into the field (presumably
    # the user wishes to change his or her password in that case)
    def password_required?
      encrypted_password.nil? || !password.blank?
    end
  
  
  
  private
  
    def initialize_user
      self.account_value = 0
      self.has_read_packet = false
    end
  
    def sanitize_user
      self.email = self.email.downcase
      self.address = strip_tags(self.address)
    end
 
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
end
