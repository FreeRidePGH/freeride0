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
    @repair_hours_entry = RepairHoursEntry.new
	@bike_id = params[:bike_id]
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repair_hours_entry }
    end
  end

  # GET /repair_hours_entries/1/edit
  def edit
    @repair_hours_entry = RepairHoursEntry.find(params[:id])
  end

  # POST /repair_hours_entries
  # POST /repair_hours_entries.json
  def create
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

  # PUT /repair_hours_entries/1
  # PUT /repair_hours_entries/1.json
  def update
    @repair_hours_entry = RepairHoursEntry.find(params[:id])

    respond_to do |format|
      if @repair_hours_entry.update_attributes(params[:repair_hours_entry])
        format.html { redirect_to @repair_hours_entry, notice: 'Repair hours entry was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
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
