class EabProjectsController < ApplicationController
  # GET /eab_projects
  # GET /eab_projects.json
  def index
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @eab_projects = EabProject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @eab_projects }
    end
  end

  # GET /eab_projects/1
  # GET /eab_projects/1.json
  def show
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @eab_project = EabProject.find(params[:id])
    
    @total_hours_spent = 0
    @eab_project.repair_hours_entries.each do |entry|
      @total_hours_spent = @total_hours_spent + entry.duration
    end
    @safety_inspections = @eab_project.bike.safety_inspections

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @eab_project }
    end
  end

  # GET /eab_projects/new
  # GET /eab_projects/new.json
  def new
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end

    @eab_project = EabProject.new
    @bikeID = params[:bike_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @eab_project }
    end
  end

  # GET /eab_projects/1/edit
  def edit
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @eab_project = EabProject.find(params[:id])
  end

  # POST /eab_projects
  # POST /eab_projects.json
  def create
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end

    @eab_project = EabProject.new(params[:eab_project])
    @eab_project.status = 1 #status 1 means EAB in progress	
    @alreadyTaken = EabProject.find_by_bike_id(@eab_project.bike_id)
    @alreadyHas = EabProject.find_by_user_id(@eab_project.user_id)

    if !@alreadyTaken.nil? && @alreadyTaken.status==1 
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Bike is currently in a project already.' }
        format.json { render json: @eab_project.errors, notice: 'Bike is currently in a project already' }
      end
    elsif !@alreadyHas.nil? && @alreadyHas.status==1
      respond_to do |format|
        format.html { redirect_to :back, notice: 'User already has an eab project in progress' }
        format.json { render json: @eab_project.errors, notice: 'User already has an eab roject in progress' }
      end		
    else
      @bike = Bike.find_by_id(@eab_project.bike_id)
      @bike.status = "EAB in Progress"
      @bike.save
      @favorite = Favorite.new(:bike_id => @eab_project.bike_id, :user_id => @eab_project.user_id)
      @favorite.save

      respond_to do |format|
        if @eab_project.save
          format.html { redirect_to @eab_project, notice: 'Eab project was successfully created.' }
          format.json { render json: @eab_project, status: :created, location: @eab_project }
        else
          format.html { render action: "new" }
          format.json { render json: @eab_project.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /eab_projects/1
  # PUT /eab_projects/1.json
  def update
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @eab_project = EabProject.find(params[:id])

    respond_to do |format|
      if @eab_project.update_attributes(params[:eab_project])
        format.html { redirect_to @eab_project, notice: 'Eab project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @eab_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eab_projects/1
  # DELETE /eab_projects/1.json
  def destroy
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @eab_project = EabProject.find(params[:id])
    @bike = Bike.find_by_id(@eab_project.bike_id)
    @bike.status = "Available"
    @bike.save
    @eab_project.destroy

    respond_to do |format|
      format.html { redirect_to eab_projects_url }
      format.json { head :ok }
    end
  end

  def myproj
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @eab_projects = current_user.eab_projects  
  end
end
