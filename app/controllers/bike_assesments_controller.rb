class BikeAssesmentsController < ApplicationController
  # GET /bike_assesments
  # GET /bike_assesments.json
 
  def index
    @bike_assesments = BikeAssesment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bike_assesments }
    end
  end

  # GET /bike_assesments/1
  # GET /bike_assesments/1.json
  def show
    @bike_assesment = BikeAssesment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bike_assesment }
    end
  end

  # GET /bike_assesments/new
  # GET /bike_assesments/new.json
  def new
    @bike_assesment = BikeAssesment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bike_assesment }
    end
  end

  # GET /bike_assesments/1/edit
  def edit
    @bike_assesment = BikeAssesment.find(params[:id])
  end

  # POST /bike_assesments
  # POST /bike_assesments.json
  def create
    @bike_assesment = BikeAssesment.new(params[:bike_assesment])

    respond_to do |format|
      if @bike_assesment.save
        format.html { redirect_to @bike_assesment, notice: 'Bike assesment was successfully created.' }
        format.json { render json: @bike_assesment, status: :created, location: @bike_assesment }
      else
        format.html { render action: "new" }
        format.json { render json: @bike_assesment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /bike_assesments/1
  # PUT /bike_assesments/1.json
  def update
    @bike_assesment = BikeAssesment.find(params[:id])

    respond_to do |format|
      if @bike_assesment.update_attributes(params[:bike_assesment])
        format.html { redirect_to @bike_assesment, notice: 'Bike assesment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bike_assesment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bike_assesments/1
  # DELETE /bike_assesments/1.json
  def destroy
    @bike_assesment = BikeAssesment.find(params[:id])
    @bike_assesment.destroy

    respond_to do |format|
      format.html { redirect_to bike_assesments_url }
      format.json { head :ok }
    end
  end
end
