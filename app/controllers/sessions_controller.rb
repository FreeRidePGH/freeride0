class SessionsController < ApplicationController
  
  skip_before_filter :check_login, :except => :destroy
  
  def create
    user = User.authenticate(params[:session][:email].downcase,
                             params[:session][:password])
    if user.nil?
      redirect_to root_path, :notice => "Email and password combination is invalid."
    else
      sign_in user
      redirect_to root_path, :notice => "Successfully logged in."
    end
  end
  
  def destroy
    sign_out
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end
  
end
