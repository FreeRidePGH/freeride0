class LocationHistoriesController < ApplicationController
  # GET /location_histories
  # GET /location_histories.json
  def index
    @location_histories = LocationHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @location_histories }
    end
  end

  # GET /location_histories/1
  # GET /location_histories/1.json
  def show
    @location_history = LocationHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location_history }
    end
  end

  # GET /location_histories/new
  # GET /location_histories/new.json
  def new
    @location_history = LocationHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location_history }
    end
  end

  # GET /location_histories/1/edit
  def edit
    @location_history = LocationHistory.find(params[:id])
  end

  # POST /location_histories
  # POST /location_histories.json
  def create
    @location_history = LocationHistory.new(params[:location_history])

    respond_to do |format|
      if @location_history.save
        format.html { redirect_to @location_history, notice: 'Location history was successfully created.' }
        format.json { render json: @location_history, status: :created, location: @location_history }
      else
        format.html { render action: "new" }
        format.json { render json: @location_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /location_histories/1
  # PUT /location_histories/1.json
  def update
    @location_history = LocationHistory.find(params[:id])

    respond_to do |format|
      if @location_history.update_attributes(params[:location_history])
        format.html { redirect_to @location_history, notice: 'Location history was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @location_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /location_histories/1
  # DELETE /location_histories/1.json
  def destroy
    @location_history = LocationHistory.find(params[:id])
    @location_history.destroy

    respond_to do |format|
      format.html { redirect_to location_histories_url }
      format.json { head :ok }
    end
  end
end
