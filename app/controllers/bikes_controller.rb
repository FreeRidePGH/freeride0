class BikesController < ApplicationController
  helper_method :sort_column, :sort_direction
  # GET /bikes
  # GET /bikes.json
  def index  
	
    @searchID = params[:searchText]
	@idtype = params[:idtype]
	if @searchID.nil?
		if !params[:sort].nil?	 && !params[:direction].nil?
			@bikes = Bike.order(params[:sort] + ' ' + params[:direction])
		else
			@bikes = Bike.all
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
	#@locname = params[:locname]
	
    respond_to do |format|
      if @bike.save
		@bike_assesment = BikeAssesment.new(:bike_id => @bike.id, :quality => @q, :condition => @c, :value => @v)
		@bike_assesment.save
		#@bike_loc = Location.new(:name => @locname)
		#@bike_loc.save
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
