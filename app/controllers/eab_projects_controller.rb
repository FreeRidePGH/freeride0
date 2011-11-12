class EabProjectsController < ApplicationController
  # GET /eab_projects
  # GET /eab_projects.json
  def index
    @eab_projects = EabProject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @eab_projects }
    end
  end

  # GET /eab_projects/1
  # GET /eab_projects/1.json
  def show
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
    @eab_project = EabProject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @eab_project }
    end
  end

  # GET /eab_projects/1/edit
  def edit
    @eab_project = EabProject.find(params[:id])
  end

  # POST /eab_projects
  # POST /eab_projects.json
  def create
    @eab_project = EabProject.new
    @eab_project.user_id = current_user.id
    @eab_project.bike_id = params[:bike_id]
    @eab_project.start_date = Time.now
	  @eab_project.status = 1

	
    respond_to do |format|
      if @eab_project.save
        @bike = Bike.find_by_id(@eab_project.bike_id)
	      @bike.status = "EAB in Progress"
	      @bike.save
        format.html { redirect_to @eab_project, notice: 'Eab project was successfully created.' }
        format.json { render json: @eab_project, status: :created, location: @eab_project }
      else
        format.html { render action: "new" }
        format.json { render json: @eab_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /eab_projects/1
  # PUT /eab_projects/1.json
  def update
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
    @eab_project = EabProject.find(params[:id])
    @eab_project.destroy

    respond_to do |format|
      format.html { redirect_to eab_projects_url }
      format.json { head :ok }
    end
  end
end
