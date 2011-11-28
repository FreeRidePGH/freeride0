class FavoritesController < ApplicationController
  # GET /favorites
  # GET /favorites.json
  def index
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @favorites = Favorite.all
	if(!params[:bike_id].nil?)
		@favorites = Favorite.where(:bike_id => params[:bike_id])
	end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @favorites }
    end
  end

  # GET /favorites/1
  # GET /favorites/1.json
  def show
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @favorite = Favorite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @favorite }
    end
  end

  # GET /favorites/new
  # GET /favorites/new.json
  def new
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @favorite = Favorite.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @favorite }
    end
  end

  # GET /favorites/1/edit
  def edit
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @favorite = Favorite.find(params[:id])
  end

  # POST /favorites
  # POST /favorites.json
  def create
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end    

    @bid = params[:bike_id]
    @uid = params[:user_id]
    @favorite = Favorite.new(:user_id => @uid, :bike_id => @bid)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to myfav_url, notice: 'Favorite was successfully created.' }
        format.json { render json: @favorite, status: :created, location: @favorite }
      else
        format.html { redirect_to myfav_url, notice: 'Bike is already in your favourites.'}
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /favorites/1
  # PUT /favorites/1.json
  def update
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @favorite = Favorite.find(params[:id])

    respond_to do |format|
      if @favorite.update_attributes(params[:favorite])
        format.html { redirect_to @favorite, notice: 'Favorite was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @favorite = Favorite.find(params[:id])
    @favorite.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :ok }
    end
  end
  
  
  def myfav

    @favs = current_user.favorites

  end  
end
