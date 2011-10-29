class ApplicationController < ActionController::Base
  
  protect_from_forgery
  include SessionsHelper

  
  before_filter :check_login
  
  
  protected
  
    def check_login
      if current_user.nil?
        flash.now[:error] = "You must login before you can access that feature."
        redirect_to root_path
      end
    end  
    
end
