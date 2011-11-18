class HomeController < ApplicationController
  
  skip_before_filter :check_login, :except => :dashboard
  
  # All users get sent here by default
  def index
    if current_user
      redirect_to dashboard_path 
      return
    end 
    @user = User.new #used for signing up a new User
  end
  
  # Logged in users get sent here from index
  def dashboard
    # get my projects
    @eab_project = current_user.eab_project
  end
  
end
