class BikeBrandsController < ApplicationController
  # GET /bike_brands
  # GET /bike_brands.json
  def index
    @bike_brands = BikeBrand.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bike_brands }
    end
  end

  # GET /bike_brands/1
  # GET /bike_brands/1.json
  def show
    @bike_brand = BikeBrand.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bike_brand }
    end
  end

  # GET /bike_brands/new
  # GET /bike_brands/new.json
  def new
    @bike_brand = BikeBrand.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bike_brand }
    end
  end

  # GET /bike_brands/1/edit
  def edit
    @bike_brand = BikeBrand.find(params[:id])
  end

  # POST /bike_brands
  # POST /bike_brands.json
  def create
    @bike_brand = BikeBrand.new(params[:bike_brand])

    respond_to do |format|
      if @bike_brand.save
        format.html { redirect_to @bike_brand, notice: 'Bike brand was successfully created.' }
        format.json { render json: @bike_brand, status: :created, location: @bike_brand }
      else
        format.html { render action: "new" }
        format.json { render json: @bike_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bike_brands/1
  # PUT /bike_brands/1.json
  def update
    @bike_brand = BikeBrand.find(params[:id])

    respond_to do |format|
      if @bike_brand.update_attributes(params[:bike_brand])
        format.html { redirect_to @bike_brand, notice: 'Bike brand was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bike_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bike_brands/1
  # DELETE /bike_brands/1.json
  def destroy
    @bike_brand = BikeBrand.find(params[:id])
    @bike_brand.destroy

    respond_to do |format|
      format.html { redirect_to bike_brands_url }
      format.json { head :ok }
    end
  end
  
  # POST /newbrandform
  # POST /newbrandform.json
  def newbrandform
    @bike_brand = BikeBrand.new(params[:bike_brand])

    respond_to do |format|
      if @bike_brand.save
        format.html { redirect_to '/bikes/new', notice: 'Bike brand was successfully created.' }
        format.json { render json: '/bikes/new', status: :created, location: @bike_brand }
      else
        format.html { render action: "new" }
        format.json { render json: @bike_brand.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
