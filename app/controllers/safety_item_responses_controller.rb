class SafetyItemResponsesController < ApplicationController
  # GET /safety_item_responses
  # GET /safety_item_responses.json
  def index
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item_responses = SafetyItemResponse.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @safety_item_responses }
    end
  end

  # GET /safety_item_responses/1
  # GET /safety_item_responses/1.json
  def show
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item_response = SafetyItemResponse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @safety_item_response }
    end
  end

  # GET /safety_item_responses/new
  # GET /safety_item_responses/new.json
  def new
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item_response = SafetyItemResponse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @safety_item_response }
    end
  end

  # GET /safety_item_responses/1/edit
  def edit
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item_response = SafetyItemResponse.find(params[:id])
  end

  # POST /safety_item_responses
  # POST /safety_item_responses.json
  def create
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item_response = SafetyItemResponse.new(params[:safety_item_response])

    respond_to do |format|
      if @safety_item_response.save
        format.html { redirect_to @safety_item_response, notice: 'Safety item response was successfully created.' }
        format.json { render json: @safety_item_response, status: :created, location: @safety_item_response }
      else
        format.html { render action: "new" }
        format.json { render json: @safety_item_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /safety_item_responses/1
  # PUT /safety_item_responses/1.json
  def update
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item_response = SafetyItemResponse.find(params[:id])

    respond_to do |format|
      if @safety_item_response.update_attributes(params[:safety_item_response])
        format.html { redirect_to @safety_item_response, notice: 'Safety item response was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @safety_item_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /safety_item_responses/1
  # DELETE /safety_item_responses/1.json
  def destroy
    if current_user.is_not_staff?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item_response = SafetyItemResponse.find(params[:id])
    @safety_item_response.destroy

    respond_to do |format|
      format.html { redirect_to safety_item_responses_url }
      format.json { head :ok }
    end
  end
end
