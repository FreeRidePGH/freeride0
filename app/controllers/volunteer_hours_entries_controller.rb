class VolunteerHoursEntriesController < ApplicationController
  # GET /volunteer_hours_entries
  # GET /volunteer_hours_entries.json
  def index
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @volunteer_hours_entries = VolunteerHoursEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @volunteer_hours_entries }
    end
  end

  # GET /volunteer_hours_entries/1
  # GET /volunteer_hours_entries/1.json
  def show
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @volunteer_hours_entry = VolunteerHoursEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @volunteer_hours_entry }
    end
  end

  # GET /volunteer_hours_entries/new
  # GET /volunteer_hours_entries/new.json
  def new
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @volunteer_hours_entry = VolunteerHoursEntry.new
    @user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @volunteer_hours_entry }
    end
  end

  # POST /volunteer_hours_entries
  # POST /volunteer_hours_entries.json
  def create
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end

    @volunteer_hours_entry = VolunteerHoursEntry.new(params[:volunteer_hours_entry])
    @volunteer_hours_entry.user_id = current_user.id
    
    #Parsing the users String DateTime into acutal DateTime objects
    @volunteer_hours_entry.start_time = DateTime.strptime(params[:start_datetime],"%m/%d/%Y %l:%M %p")
    @volunteer_hours_entry.end_time = DateTime.strptime(params[:end_datetime],"%m/%d/%Y %l:%M %p")

    if @volunteer_hours_entry.end_time < @volunteer_hours_entry.start_time
      @volunteer_hours_entry.errors.add(:start_time, "is passed your End time")
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @volunteer_hours_entry.errors, status: :unprocessable_entity }
      end
      return
    end
    
    if @volunteer_hours_entry.end_time.to_date != @volunteer_hours_entry.start_time.to_date
    @volunteer_hours_entry.errors.add(:end_time, "is not in the same Day")
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @volunteer_hours_entry.errors, status: :unprocessable_entity }
      end
      return
    end
    
    respond_to do |format|
      if @volunteer_hours_entry.save
        format.html { redirect_to @volunteer_hours_entry, notice: 'Volunteer hours entry was successfully created.' }
        format.json { render json: @volunteer_hours_entry, status: :created, location: @volunteer_hours_entry }
        
        @transaction = Transaction.new
        @transaction.user = current_user
        seconds_in_hour = 60.0*60.0
        hours_worked = (@volunteer_hours_entry.end_time - @volunteer_hours_entry.start_time)/seconds_in_hour
        payrate = 8.00
        @transaction.amount = payrate*hours_worked
        @transaction.note = sprintf("%.2f", hours_worked) + " Volunteer Hours for " + @volunteer_hours_entry.date
        @transaction.save
      
      else
        format.html { render action: "new" }
        format.json { render json: @volunteer_hours_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteer_hours_entries/1
  # DELETE /volunteer_hours_entries/1.json
  def destroy
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @volunteer_hours_entry = VolunteerHoursEntry.find(params[:id])
    @volunteer_hours_entry.destroy

    respond_to do |format|
      format.html { redirect_to volunteer_hours_entries_url }
      format.json { head :ok }
    end
  end
  
  def myhours
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @volunteer_hours_entries = current_user.volunteer_hours_entries 
  end
end
