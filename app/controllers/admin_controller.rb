class AdminController < ApplicationController

  def index
    if current_user.is_not_council?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
  end

end