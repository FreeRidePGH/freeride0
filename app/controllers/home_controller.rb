class HomeController < ApplicationController
  
  # All users get sent here by default
  def index
    #temporary redirect of all users to be logged in until sessions are implemented
    redirect_to dashboard_path
  end
  
  # Logged in users get sent here from index
  def dashboard
    
  end
  
end
