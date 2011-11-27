class SearchController < ApplicationController
  
  skip_before_filter :check_login
  before_filter :guest_login
  
  def index
  end

  def results
  end
  
end
