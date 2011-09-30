class BikeModelsController < ApplicationController
  # GET /bike_models
  # GET /bike_models.json
  def index
    @bike_models = BikeModel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bike_models }
    end
  end

  # GET /bike_models/1
  # GET /bike_models/1.json
  def show
    @bike_model = BikeModel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bike_model }
    end
  end

  # GET /bike_models/new
  # GET /bike_models/new.json
  def new
    @bike_model = BikeModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bike_model }
    end
  end

  # GET /bike_models/1/edit
  def edit
    @bike_model = BikeModel.find(params[:id])
  end

  # POST /bike_models
  # POST /bike_models.json
  def create
    @bike_model = BikeModel.new(params[:bike_model])

    respond_to do |format|
      if @bike_model.save
        format.html { redirect_to @bike_model, notice: 'Bike model was successfully created.' }
        format.json { render json: @bike_model, status: :created, location: @bike_model }
      else
        format.html { render action: "new" }
        format.json { render json: @bike_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bike_models/1
  # PUT /bike_models/1.json
  def update
    @bike_model = BikeModel.find(params[:id])

    respond_to do |format|
      if @bike_model.update_attributes(params[:bike_model])
        format.html { redirect_to @bike_model, notice: 'Bike model was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bike_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bike_models/1
  # DELETE /bike_models/1.json
  def destroy
    @bike_model = BikeModel.find(params[:id])
    @bike_model.destroy

    respond_to do |format|
      format.html { redirect_to bike_models_url }
      format.json { head :ok }
    end
  end
end
