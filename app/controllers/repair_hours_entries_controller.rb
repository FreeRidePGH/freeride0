class RepairHoursEntriesController < ApplicationController
  # GET /repair_hours_entries
  # GET /repair_hours_entries.json
  def index
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @repair_hours_entries = RepairHoursEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repair_hours_entries }
    end
  end

  # GET /repair_hours_entries/1
  # GET /repair_hours_entries/1.json
  def show
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @repair_hours_entry = RepairHoursEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repair_hours_entry }
    end
  end

  # GET /repair_hours_entries/new
  # GET /repair_hours_entries/new.json
  def new
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    if current_user.active_eab_project.nil? || current_user.active_eab_project.status >= 400
      flash[:error] = "You do not have an active EAB Project."
      redirect_to root_path and return
    end

    @repair_hours_entry = RepairHoursEntry.new
	  @bike_id = current_user.active_eab_project.bike.id
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repair_hours_entry }
    end
  end

  # POST /repair_hours_entries
  # POST /repair_hours_entries.json
  def create
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @repair_hours_entry = RepairHoursEntry.new(params[:repair_hours_entry])
    @repair_hours_entry.user_id = current_user.id
    @repair_hours_entry.eab_project_id = params[:eab]
    @repair_hours_entry.bike_id = EabProject.find(@repair_hours_entry.eab_project_id).bike_id
    
    if @repair_hours_entry.end_time < @repair_hours_entry.start_time
      @repair_hours_entry.errors.add(:start_time, "is passed your End time")
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @repair_hours_entry.errors, status: :unprocessable_entity }
      end
      return
    end
    
    if @repair_hours_entry.end_time.to_date != @repair_hours_entry.start_time.to_date
    @repair_hours_entry.errors.add(:end_time, "is not in the same Day")
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @repair_hours_entry.errors, status: :unprocessable_entity }
      end
      return
    end
    
    respond_to do |format|
      if @repair_hours_entry.save
        format.html { redirect_to @repair_hours_entry, notice: 'Repair hours entry was successfully created.' }
        format.json { render json: @repair_hours_entry, status: :created, location: @repair_hours_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @repair_hours_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repair_hours_entries/1
  # DELETE /repair_hours_entries/1.json
  def destroy
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @repair_hours_entry = RepairHoursEntry.find(params[:id])
    @repair_hours_entry.destroy

    respond_to do |format|
      format.html { redirect_to repair_hours_entries_url }
      format.json { head :ok }
    end
  end
end
