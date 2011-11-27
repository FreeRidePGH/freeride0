class ApplicationController < ActionController::Base
  
  protect_from_forgery
  include SessionsHelper

  before_filter :check_login
  
  
  protected
  
    def check_login
      if current_user.nil?
        flash[:error] = "You must login before you can access that feature."
        redirect_to root_path
      end
    end
    
    def guest_login
      if current_user.nil?
        user = User.new
        user.id = 0
        user.first_name = "Guest"
        user.last_name = "User"
        user.email = "guest@freeridepgh.org"
        user.encrypted_password = ""
        user.salt = ""
        user.account_value = 0
        user.has_read_packet = false
        user.role = 0
        user.phone_number = ""
        user.can_text_phone = false
        user.address = ""
        sign_in_guest user
      end
    end
    
end
