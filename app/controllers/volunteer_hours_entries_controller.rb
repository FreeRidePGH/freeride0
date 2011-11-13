class VolunteerHoursEntriesController < ApplicationController
  # GET /volunteer_hours_entries
  # GET /volunteer_hours_entries.json
  def index
    @volunteer_hours_entries = VolunteerHoursEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @volunteer_hours_entries }
    end
  end

  # GET /volunteer_hours_entries/1
  # GET /volunteer_hours_entries/1.json
  def show
    @volunteer_hours_entry = VolunteerHoursEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @volunteer_hours_entry }
    end
  end

  # GET /volunteer_hours_entries/new
  # GET /volunteer_hours_entries/new.json
  def new
    @volunteer_hours_entry = VolunteerHoursEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @volunteer_hours_entry }
    end
  end

  # GET /volunteer_hours_entries/1/edit
  def edit
    @volunteer_hours_entry = VolunteerHoursEntry.find(params[:id])
  end

  # POST /volunteer_hours_entries
  # POST /volunteer_hours_entries.json
  def create
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

  # PUT /volunteer_hours_entries/1
  # PUT /volunteer_hours_entries/1.json
  def update
    @volunteer_hours_entry = VolunteerHoursEntry.find(params[:id])

    respond_to do |format|
      if @volunteer_hours_entry.update_attributes(params[:volunteer_hours_entry])
        format.html { redirect_to @volunteer_hours_entry, notice: 'Volunteer hours entry was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @volunteer_hours_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteer_hours_entries/1
  # DELETE /volunteer_hours_entries/1.json
  def destroy
    @volunteer_hours_entry = VolunteerHoursEntry.find(params[:id])
    @volunteer_hours_entry.destroy

    respond_to do |format|
      format.html { redirect_to volunteer_hours_entries_url }
      format.json { head :ok }
    end
  end
  
  def myhours
    @volunteer_hours_entries = VolunteerHoursEntry.all  
  end
end
