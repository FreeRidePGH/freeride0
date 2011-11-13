class RepairHoursEntriesController < ApplicationController
  # GET /repair_hours_entries
  # GET /repair_hours_entries.json
  def index
    @repair_hours_entries = RepairHoursEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repair_hours_entries }
    end
  end

  # GET /repair_hours_entries/1
  # GET /repair_hours_entries/1.json
  def show
    @repair_hours_entry = RepairHoursEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repair_hours_entry }
    end
  end

  # GET /repair_hours_entries/new
  # GET /repair_hours_entries/new.json
  def new
    if current_user.eab_project.nil? || current_user.eab_project.status != 1
      respond_to do |format|
        format.html { redirect_to :root, error: 'You do not have an EAB Project' }
      end
      return
    end
    #project = current_user.eab_project.find(:bike_id => bike_id)
    #if project.nil? || project.status != 1
    # redirect_to location: :back
    #end
    @repair_hours_entry = RepairHoursEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repair_hours_entry }
    end
  end

  # POST /repair_hours_entries
  # POST /repair_hours_entries.json
  def create
    @repair_hours_entry = RepairHoursEntry.new(params[:repair_hours_entry])
    #@repair_hours_entry.end_time = Date.strptime(params["end"], '%m/%d/%Y %H:%M')
    #@repair_hours_entry.start_time = Date.strptime(params["start"], '%m/%d/%Y %H:%M')

    @repair_hours_entry.user_id = current_user.id
    @repair_hours_entry.eab_project_id = params[:eab]
    @repair_hours_entry.bike_id = EabProject.find(@repair_hours_entry.eab_project_id).bike_id
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
    @repair_hours_entry = RepairHoursEntry.find(params[:id])
    @repair_hours_entry.destroy

    respond_to do |format|
      format.html { redirect_to repair_hours_entries_url }
      format.json { head :ok }
    end
  end
end
