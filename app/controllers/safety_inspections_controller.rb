class SafetyInspectionsController < ApplicationController
  # GET /safety_inspections
  # GET /safety_inspections.json
  def index
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_inspections = SafetyInspection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @safety_inspections }
    end
  end

  # GET /safety_inspections/1
  # GET /safety_inspections/1.json
  def show
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_inspection = SafetyInspection.find(params[:id])
    @safety_item_responses = @safety_inspection.safety_item_responses

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @safety_inspection }
    end
  end

  # GET /safety_inspections/new
  # GET /safety_inspections/new.json
  def new
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_inspection = SafetyInspection.new
    @safety_inspection.bike = Bike.find(params[:bike_id])
    @safety_inspection.inspector = current_user
    
    SafetyItem.all.each do |safety_item|
      @safety_inspection.safety_item_responses.build(:safety_item_id => safety_item.id)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @safety_inspection }
    end
  end

  # GET /safety_inspections/1/edit
  def edit
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_inspection = SafetyInspection.find(params[:id])
  end

  # POST /safety_inspections
  # POST /safety_inspections.json
  def create
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_inspection = SafetyInspection.new(params[:safety_inspection])
    @safety_inspection.bike = Bike.find(params[:safety_inspection][:bike_id])
    @safety_inspection.inspector = current_user

    respond_to do |format|
      if @safety_inspection.save
        format.html { redirect_to @safety_inspection, notice: 'Safety inspection was successfully created.' }
        format.json { render json: @safety_inspection, status: :created, location: @safety_inspection }
      else
        format.html { render action: "new" }
        format.json { render json: @safety_inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /safety_inspections/1
  # PUT /safety_inspections/1.json
  def update
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_inspection = SafetyInspection.find(params[:id])

    respond_to do |format|
      if @safety_inspection.update_attributes(params[:safety_inspection])
        format.html { redirect_to @safety_inspection, notice: 'Safety inspection was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @safety_inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /safety_inspections/1
  # DELETE /safety_inspections/1.json
  def destroy
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_inspection = SafetyInspection.find(params[:id])
    @safety_inspection.destroy

    respond_to do |format|
      format.html { redirect_to safety_inspections_url }
      format.json { head :ok }
    end
  end
end
