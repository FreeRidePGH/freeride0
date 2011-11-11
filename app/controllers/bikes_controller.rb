class BikesController < ApplicationController
  helper_method :sort_column, :sort_direction
  # GET /bikes
  # GET /bikes.json
  def index  
	
    @searchID = params[:searchText]
	@idtype = params[:idtype]
	if @searchID.nil?
		if !params[:sort].nil?	 && !params[:direction].nil? #Sort column was clicked
			@bikes = Bike.order(params[:sort] + ' ' + params[:direction])
		else
			#nothing selected, display all
			@bikes = Bike.all
			
			#if a category was chosen, display it
			@brand = params[:brand]
			@color = params[:color]
			@status = params[:status]
			@wheel_size = params[:wheel_size]
			@top_tube = params[:top_tube]
			@seat_tube = params[:seat_tube]
			
			if !@brand.nil?
				@bikes = Bike.where(:brand_id => @brand)
			end
			if !@color.nil?
				@bikes = Bike.where(:color => @color)
			end
			if !@status.nil?
				@bikes = Bike.where(:status => @status)
			end
			if !@wheel_size.nil?
				@bikes = Bike.where(:wheel_size => @wheel_size)
			end
			if !@top_tube.nil?
				@bikes = Bike.where(:top_tube => @top_tube)
			end
			if !@seat_tube.nil?
				@bikes = Bike.where(:seat_tube => @seat_tube)
			end
						
		end
	elsif @idtype == "bikeID"
		@bikes = Bike.where(:id => @searchID)
	else
		@bikes = Bike.where(:location_id => Location.find_by_hook_number(@searchID))
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

  # GET /bikes/new
  # GET /bikes/new.json
  def new
    @bike = Bike.new
	@models = BikeModel.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bike }
    end
  end

  # GET /bikes/1/edit
  def edit
    @bike = Bike.find(params[:id])
  end

  # POST /bikes
  # POST /bikes.json
  def create
	@models = BikeModel.find(:all)
    @bike = Bike.new(params[:bike])
	@bike.status = "Available"
	@q = params[:quality]
	@c = params[:condition]
	@v = params[:value]
	@locname = params[:locname]
	
	@hooknum = @bike.location_id #location_id was actually hook number	
	if @hooknum.nil?			
		if !@locname.nil?
			@loc = Location.find_by_id(@locname)
			if !@loc.nil?
				@bike.location_id = @loc.id
			else
				#both hooknum and location not entered
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
			#location exist, just add it to the bike
			@bike.location_id = @loc.id
		end
	end
	
	
    respond_to do |format|
      if @bike.save
		@bike_assesment = BikeAssesment.new(:bike_id => @bike.id, :quality => @q, :condition => @c, :value => @v)
		@bike_assesment.save
        format.html { redirect_to @bike, notice: 'Bike was successfully created.' }
        format.json { render json: @bike, status: :created, location: @bike }
      else
        format.html { render action: "new" }
        format.json { render json: @bike.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bikes/1
  # PUT /bikes/1.json
  def update
    @bike = Bike.find(params[:id])

    respond_to do |format|
      if @bike.update_attributes(params[:bike])
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
    @bike = Bike.find(params[:id])
    @bike.destroy

    respond_to do |format|
      format.html { redirect_to bikes_url }
      format.json { head :ok }
    end
  end

  # POST /newbrandform
  # POST /newbrandform.json
  def newbrandform
    @bike_brand = BikeBrand.new(params[:bike_brand])
    @bike = Bike.new(params[:bike])
	
    respond_to do |format|
      if @bike_brand.save
		
        format.html { redirect_to '/bikes/new', notice: 'Bike brand was successfully created.' }
        format.json { render json: @bike, status: :created, location: @bike }
      else
        format.html { render action: "new" }
        format.json { render json: @bike, status: :unprocessable_entity }
      end
    end
  end  
 
  # POST /newmodelform
  # POST /newmodelform.json
  def newmodelform
    @bike_model = BikeModel.new(params[:bike_model])
	@bike = Bike.new(params[:bike])

    respond_to do |format|
      if @bike_model.save
        format.html { redirect_to '/bikes/new', notice: 'Bike model was successfully created.' }
        format.json { render json: @bike, status: :created, location: @bike_model }
      else
        format.html { render action: "new" }
        format.json { render json: @bike, status: :unprocessable_entity }
      end
    end
  end
  
  private
  def sort_column
    Bike.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end
