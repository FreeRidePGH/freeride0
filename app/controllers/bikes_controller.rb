class BikesController < ApplicationController
  
  skip_before_filter :check_login, :only => [:index, :show]
  before_filter :guest_login, :only => [:index, :show]
  
  helper_method :sort_column, :sort_direction, :is_number?
  layout 'application', :except => :printview
  
  # GET /bikes
  # GET /bikes.json
  def index  

    @searchID = params[:searchText]
    if @searchID.nil?
      #Display all (page was directly accessed)
      @bikes = Bike.order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])
      
	  # -- Search Code --
      #if a category was chosen, display it
      @brand = params[:brand]
      @color = params[:color]
      @status = params[:status]
      @wheel_size = params[:wheel_size]
      @top_tube = params[:top_tube]
      @seat_tube = params[:seat_tube]

      if !@brand.nil?
        @bikes = Bike.where(:brand_id => @brand).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])
		@brand = Integer(@brand)
      end
      if !@color.nil?
        @bikes = Bike.where(:color => @color).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])
      end
      if !@status.nil?
        @bikes = Bike.searchStatus(@status).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])
      end
      if !@wheel_size.nil?
        @bikes = Bike.where(:wheel_size => @wheel_size).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])
		@wheel_size = @wheel_size.to_f
	  end
      if !@top_tube.nil?
        @bikes = Bike.where(:top_tube => @top_tube).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])
		@top_tube = @top_tube.to_f
	  end
      if !@seat_tube.nil?
        @bikes = Bike.where(:seat_tube => @seat_tube).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])
		@seat_tube = @seat_tube.to_f
	  end
	  # -- End of search code --
	  
	  # -- Filter Menu code --	  
	  if !params[:filterSectionUsed].nil?
		  @brandfilter = params[:brandfilter]
		  @wheelfilter = params[:wheelfilter]
		  @toptubefilter = params[:toptubefilter]
		  @seattubefilter = params[:seattubefilter]
		  @colorfilter = params[:colorfilter]
		  @statusfilter = params[:statusfilter]
		  
		  #Get all bikes ordered and paginated
		  @bikes = Bike.where('id > 0').order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page]).compact
		  if @brandfilter != "All"
			@brandfilter = Integer(@brandfilter)
			@bikes.delete_if {|x| x.brand_id!=@brandfilter}
		  end
		  
		  if @wheelfilter != "All"
			@wheelfilter = @wheelfilter.to_f
			@bikes.delete_if {|x| x.wheel_size!=@wheelfilter}
		  end
		  
		  if @toptubefilter != "All"
			@toptubefilter = @toptubefilter.to_f
			@bikes.delete_if {|x| x.top_tube!=@toptubefilter}
		  end
		  
		  if @seattubefilter != "All"
			@seattubefilter = @seattubefilter.to_f
			@bikes.delete_if {|x| x.seat_tube!=@seattubefilter}
		  end
		  
		  if @colorfilter != "All"
			@bikes.delete_if {|x| x.color!=@colorfilter}
		  end
		  
		  if @statusfilter != "All"
			@bikes.delete_if {|x| x.status!=@statusfilter}
		  end
		  
	  
	  end	  
	  # -- End of Filter Menu code --

	# Query came from search page ID/Hook box
    else
      @bikes = Bike.where("bike_id = ? OR location_id = ?", @searchID, Location.find_by_hook_number(@searchID)).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])
      
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bikes }
    end
  end

  # GET /bikes/1
  # GET /bikes/1.json
  def show
    @bike = Bike.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bike }
    end
  end

  def printview
    @bike = Bike.find(params[:id])
	@bikeassmt = BikeAssesment.find_by_bike_id(@bike.id)
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @bike, :layout => false  }
    end
  end
  
  # GET /bikes/new
  # GET /bikes/new.json
  def new
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @bike = Bike.new
    @models = BikeModel.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bike }
    end
  end

  # GET /bikes/1/edit
  def edit
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    @bike = Bike.find(params[:id])
    @models = BikeModel.find(:all)
  end

  # POST /bikes
  # POST /bikes.json
  def create
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @models = BikeModel.find(:all)
    @bike = Bike.new(params[:bike])
	@bike.checkdefaults
    @bike.status = "Available"
    @q = params[:quality]
    @c = params[:condition]
    @v = params[:value]
	@v = 0.0 unless !params[:value].blank?
    @locname = params[:locname]
	
    #Checking and adding new brand/models
    if !params[:tempbrand].nil?	
      @bike_brand = BikeBrand.new(:name => params[:tempbrand])		
      if @bike_brand.save      
        @bike.brand_id = @bike_brand.id   

      else
        @bike.errors.add(:brand_id, "is invalid or already exists")
        respond_to do |format|
          format.html { render action: "new" }
          format.json { render json: @bike.errors, status: :unprocessable_entity }				
        end
        return
      end			
    end	

    if !params[:tempmodel].nil?
      @bike_model = BikeModel.new(:brand_id => @bike.brand_id, :name => params[:tempmodel])
      if @bike_model.save      
        @bike.model_id = @bike_model.id		
      else
        @bike.errors.add(:model_id, "is invalid or already exists")
        respond_to do |format|
          format.html { render action: "new" }
          format.json { render json: @bike.errors, status: :unprocessable_entity }				
        end
        return
      end		
    end

    @hooknum = @bike.location_id #location_id was actually hook number	
    if @hooknum.nil?			
      if !@locname.nil?
        @loc = Location.find_by_id(@locname)
        if !@loc.nil?
          @bike.location_id = @loc.id
        else
          #both hooknum and location not entered, default location: off-hook
          @offhook = Location.find_by_name("In Shop - Off Hook")
          if @offhook.nil?
            @offhook = Location.new(:name => "In Shop - Off Hook")
            @offhook.save
          end
          @bike.location_id = @offhook.id
        end
      end
    else		
      @loc = Location.find_by_hook_number(@hooknum)
      if @loc.nil?
        #if location does not exist, create it
        @newloc = Location.new(:hook_number => @hooknum)
        @newloc.save
        @bike.location_id = @newloc.id
      else
        #location exist, check if hook number already taken
        if !Bike.find_by_location_id(@loc.id).nil?
          @bike.errors.add(:hook, "Number already taken")
          respond_to do |format|
            format.html { render action: "new" }
            format.json { render json: @bike.errors, status: :unprocessable_entity }				
          end
          return
        else
          @bike.location_id = @loc.id
        end
      end
    end

    respond_to do |format|
      if @bike.save
        @bike_assesment = BikeAssesment.new(:user_id => current_user.id, :bike_id => @bike.id, :quality => @q, :condition => @c, :value => @v)
        @bike_assesment.save
		@note = Note.new(:user_id => current_user.id, :bike_id => @bike.id, :title => "Bike created", :last_update => Time.now)
		@note.save
        if(params[:submit] == "Add Bike") #Create and go to bike profile page
          format.html { redirect_to @bike, notice: 'Bike was successfully created.' }
          format.json { render json: @bike, status: :created, location: @bike }
        else 							#Create and go back to new bike page
          format.html { redirect_to "/bikes/new", notice: 'Bike was successfully created.' }
          format.json { render json: @bike, status: :created, location: @bike }		
        end
      else
        format.html { render action: "new" }
        format.json { render json: @bike.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bikes/1
  # PUT /bikes/1.json
  def update
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end

    @bike = Bike.find(params[:id])
    @models = BikeModel.find(:all)
    @originalLoc = @bike.location_id
    @originalLocHist = Location.find_by_id(@originalLoc)
    if !@originalLocHist.nil?
      if @originalLocHist.name.nil?
        @historyName = "HookID - " + @originalLocHist.hook_number.to_s()
      else
        @historyName = @originalLocHist.name
      end
    end

    @bike_assesment = BikeAssesment.find_by_bike_id(@bike.id)
    @bike_assesment.quality = params[:quality]
    @bike_assesment.condition = params[:condition]
    @bike_assesment.value = params[:value]
	@bike_assesment.value = 0.0 unless !params[:value].blank?
    @bike_assesment.save

    respond_to do |format|
      if @bike.update_attributes(params[:bike])
		if !params[:hasdateout].blank?
			@bike.date_out=nil
		end
		@bike.checkdefaults
		@bike.save
        #Checking and adding new brand/models. 
        #Have to check in this block because the bike is being updated here
        if !params[:tempbrand].nil?	
          @bike_brand = BikeBrand.new(:name => params[:tempbrand])		
          if @bike_brand.save      
            @bike.brand_id = @bike_brand.id   
            @bike.save
          else
            @bike.errors.add(:brand_id, "is invalid or already exists")
            respond_to do |format|
              format.html { render action: "new" }
              format.json { render json: @bike.errors, status: :unprocessable_entity }				
            end
            return
          end			
        end	

        if !params[:tempmodel].nil?
          @bike_model = BikeModel.new(:brand_id => @bike.brand_id, :name => params[:tempmodel])
          if @bike_model.save      
            @bike.model_id = @bike_model.id	
            @bike.save
          else
            @bike.errors.add(:model_id, "is invalid or already exists")
            respond_to do |format|
              format.html { render action: "new" }
              format.json { render json: @bike.errors, status: :unprocessable_entity }				
            end
            return
          end		
        end	  

        @locname = params[:locname]
        @hooknum = @bike.location_id #location_id was actually hook number
        if @hooknum.nil? #hooknumber not entered, bike is off-hook		
          if !@locname.nil? #location name was entered
            @loc = Location.find_by_id(@locname)
            if !@loc.nil?
              if @locname != @originalLoc #execute only if value entered was not the same as the original
                @lochistory = LocationHistory.new(:bike_id => @bike.id, :location_name => @historyName, :last_date_at_location => Time.now)
                @lochistory.save
                @bike.location_id = @loc.id
              end
            else
              #both hooknum and location not entered
              @offhook = Location.find_by_name("In Shop - Off Hook")
              if @offhook.nil?
                @offhook = Location.new(:name => "In Shop - Off Hook")
                @offhook.save
              end
              @bike.location_id = @offhook.id						
            end
          end
        else #hooknumber entered
          @loc = Location.find_by_hook_number(@hooknum)
          if @loc.nil?
            #if location(hook Number) does not exist, create it
            @newloc = Location.new(:hook_number => @hooknum)
            @newloc.save
            @lochistory = LocationHistory.new(:bike_id => @bike.id, :location_name => @historyName, :last_date_at_location => Time.now)
            @lochistory.save
            @bike.location_id = @newloc.id
          else
            #location exist, check if hook number already taken
            if !Bike.find_by_location_id(@loc.id).nil?
              @bike.errors.add(:Hook, "number already taken")
              respond_to do |format|
                format.html { redirect_to :back, notice: 'Hook number already taken' }
                format.json { render json: @bike.errors, status: :unprocessable_entity }				
              end
              @bike.location_id = @originalLoc
              return
            else
              if @loc.id != @originalLoc
                @lochistory = LocationHistory.new(:bike_id => @bike.id, :location_name => @historyName, :last_date_at_location => Time.now)
                @lochistory.save
              end
              @bike.location_id = @loc.id
            end
          end
        end
        @bike.save
		@note = Note.new(:user_id => current_user.id, :bike_id => @bike.id, :title => "Bike info updated", :last_update => Time.now)
		@note.save
        format.html { redirect_to @bike, notice: 'Bike was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bike.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bikes/1
  # DELETE /bikes/1.json
  def destroy
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @bike = Bike.find(params[:id])
    @bike.destroy
	for i in Favorite.where(:bike_id => params[:id])
		i.destroy
	end	
	for i in Note.where(:bike_id => params[:id])
		i.destroy
	end
	for i in LocationHistory.where(:bike_id => params[:id])
		i.destroy
	end	
	for i in BikeAssesment.where(:bike_id => params[:id])
		i.destroy
	end	
	for i in RepairHoursEntry.where(:bike_id => params[:id])
		i.destroy
	end	
	
	#for i in EabProject.where(:bike_id => params[:id])
	#	i.destroy
	#end	

    respond_to do |format|
      format.html { redirect_to bikes_url }
      format.json { head :ok }
    end
  end
  
  def is_number?(object)
	true if Integer(object) rescue false
  end

  def reports
  
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
	
	@numBikes = Bike.all.count
	@totalProjs = EabProject.all.count
	@availBikes = Bike.where(:status => "Available").count
	@activeProjs = EabProject.where("status < 400").count
	@totalMembers = User.all.count
			
	@reportType = params[:reportType]
	@inactiveFor = params[:inactiveFor]
	if params[:reportType] == "Inactive Bikes" || params[:reportType] == "Inactive EABs" 
		if !@inactiveFor.nil? && !is_number?(@inactiveFor)
			flash[:error] = "Please enter a valid number"
			redirect_to :back and return	
		end
	end

	if !params[:reportType].nil? 
		@bikes = Array.new
		if params[:reportType] == "Inactive Bikes"
			# for inactive bikes
			for i in Bike.all
				lastactive = (Date.today - i.updated_at.to_date()) / 7
				sinceCheckin = (Date.today - i.date_in.to_date()) / 7
				departedList = ["Sold", "Departed-FFS", "Departed-EAB", "Departed-ASIS", "Departed-Scrap", "Departed-Other"]
				#ignore if bike is in any of the status above
				if !departedList.include?(i.status)
					if lastactive > Integer(params[:inactiveFor])
						@bikes << i
					elsif (sinceCheckin > Integer(params[:inactiveFor]) ) && (i.status == "Available" || i.status == "In Shop" || i.status == "Other")
						@bikes << i
					end				
				end
			end
		elsif params[:reportType] == "Inactive EABs" 
			# for inactive EABS
			for i in Bike.all
				project = EabProject.find_by_bike_id(i.id)
				if !project.nil? && project.status!=400 && project.status!=600 #not completed or abandoned
					lastactiveEAB = (Date.today - project.last_active.to_date()) / 7
					if lastactiveEAB > Integer(params[:inactiveFor])
						@bikes << i
					end
				end
			end
		end
	end

  end
 
  private
  def sort_column
    Bike.column_names.include?(params[:sort]) ? params[:sort] : "bike_id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end
