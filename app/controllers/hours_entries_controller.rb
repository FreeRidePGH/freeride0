class HoursEntriesController < ApplicationController
  
  # GET /hours_entries
  # GET /hours_entries.json
  def index
    if current_user.is_not_member?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @hours_entries = VolunteerHoursEntry.all
    @hours_entries += RepairHoursEntry.all
    @hours_entries =  @hours_entries.sort_by(&:start_time)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hours_entries }
    end
  end

  # GET /volunteer_hours_entries/1
  # GET /volunteer_hours_entries/1.json
  def volunteer_show
    if current_user.is_not_member?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @volunteer_hours_entry = VolunteerHoursEntry.find(params[:id])

    respond_to do |format|
      format.html # show_volunteer.html.erb
      format.json { render json: @volunteer_hours_entry }
    end
  end
  
  # GET /repair_hours_entries/1
  # GET /repair_hours_entries/1.json
  def repair_show
    if current_user.is_not_member?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @repair_hours_entry = RepairHoursEntry.find(params[:id])
      
      respond_to do |format|
        format.html # show_repair.html.erb
        format.json { render json: @repair_hours_entry }
      end
  end
  

  # GET /volunteer_hours_entries/new
  # GET /volunteer_hours_entries/new.json
  def volunteer_new
    if current_user.is_not_member?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @volunteer_hours_entry = VolunteerHoursEntry.new

    respond_to do |format|
      format.html # new_volunteer.html.erb
      format.json { render json: @volunteer_hours_entry }
    end
  end

  # GET /repair_hours_entries/new
  # GET /repair_hours_entries/new.json
  def repair_new
    if current_user.is_not_member?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @repair_hours_entry = RepairHoursEntry.new

    respond_to do |format|
      format.html # new_repair.html.erb
      format.json { render json: @repair_hours_entry }
    end
  end

  # POST /volunteer_hours_entries
  # POST /volunteer_hours_entries.json
  def volunteer_create
    if current_user.is_not_member?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @volunteer_hours_entry = VolunteerHoursEntry.new(params[:volunteer_hours_entry])

    respond_to do |format|
      if @volunteer_hours_entry.save
        format.html { redirect_to @volunteer_hours_entry, notice: 'Volunteer hours entry was successfully created.' }
        format.json { render json: @volunteer_hours_entry, status: :created, location: @volunteer_hours_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @volunteer_hours_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # POST /repair_hours_entries
  # POST /repair_hours_entries.json
  def repair_create
    if current_user.is_not_member?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @repair_hours_entry = RepairHoursEntry.new(params[:repair_hours_entry])

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
    
  
  # DELETE /volunteer_hours_entries/1
  # DELETE /volunteer_hours_entries/1.json
  def volunteer_destroy
    if current_user.is_not_member?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @volunteer_hours_entry = VolunteerHoursEntry.find(params[:id])
    @volunteer_hours_entry.destroy

    respond_to do |format|
      format.html { redirect_to volunteer_hours_entries_url }
      format.json { head :ok }
    end
  end
  
  # DELETE /repair_hours_entries/1
  # DELETE /repair_hours_entries/1.json
  def repair_destroy
    if current_user.is_not_member?
      flash.now[:error] = "You do not have permissions to access that feature."
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
