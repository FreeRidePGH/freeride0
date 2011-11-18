class SafetyItemsController < ApplicationController
  # GET /safety_items
  # GET /safety_items.json
  def index
    if current_user.is_not_staff?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_items = SafetyItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @safety_items }
    end
  end

  # GET /safety_items/1
  # GET /safety_items/1.json
  def show
    if current_user.is_not_member?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item = SafetyItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @safety_item }
    end
  end

  # GET /safety_items/new
  # GET /safety_items/new.json
  def new
    if current_user.is_not_staff?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item = SafetyItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @safety_item }
    end
  end

  # GET /safety_items/1/edit
  def edit
    if current_user.is_not_staff?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item = SafetyItem.find(params[:id])
  end

  # POST /safety_items
  # POST /safety_items.json
  def create
    if current_user.is_not_staff?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item = SafetyItem.new(params[:safety_item])

    respond_to do |format|
      if @safety_item.save
        format.html { redirect_to safety_items_url, notice: 'Safety item was successfully created.' }
        format.json { render json: @safety_item, status: :created, location: @safety_item }
      else
        format.html { render action: "new" }
        format.json { render json: @safety_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /safety_items/1
  # PUT /safety_items/1.json
  def update
    if current_user.is_not_staff?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item = SafetyItem.find(params[:id])

    respond_to do |format|
      if @safety_item.update_attributes(params[:safety_item])
        format.html { redirect_to safety_items_url, notice: 'Safety item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @safety_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /safety_items/1
  # DELETE /safety_items/1.json
  def destroy
    if current_user.is_not_staff?
      flash.now[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @safety_item = SafetyItem.find(params[:id])
    @safety_item.destroy

    respond_to do |format|
      format.html { redirect_to safety_items_url }
      format.json { head :ok }
    end
  end
end
