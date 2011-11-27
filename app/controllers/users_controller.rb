class UsersController < ApplicationController
  
  skip_before_filter :check_login, :only => [:new, :create]
  
  # GET /users
  # GET /users.json
  def index
    if current_user.is_not_council?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @term = (params[:q])
    if @term == nil
      @users = User.all
    else
      @users = User.search(@term)
    end
    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @users }
    end
  end 

  # GET /users/1
  # GET /users/1.json
  def show
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @user = User.find(params[:id])
	@favs = Favorite.where(:user_id => @user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    
    if current_user
      redirect_to(root_path, :alert => 'You are already registered.')
    else
      @user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.json  { render json: @user }
      end
    end
  
  end

  # GET /users/1/edit
  def edit
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @user = User.find(params[:id])
    @user.phone1 = @user.phone_number[0..2]
    @user.phone2 = @user.phone_number[3..5]
    @user.phone3 = @user.phone_number[6..9]
    
    if @user != current_user && current_user.is_not_council?
      flash[:error] = "You do not have permissions to edit other users."
      redirect_to root_path and return
    end
  end

  # POST /users
  # POST /users.json
  def create
    
    if current_user
      redirect_to(root_path, :alert => 'You cannot register a new account.')
    else
    
      @user = User.new(params[:user])
      @user.phone_number = params[:user][:phone1]+params[:user][:phone2]+params[:user][:phone3]
      
      respond_to do |format|
        if @user.save
          sign_in @user   # sign in the user right away after they register
          format.html { redirect_to root_path, notice: 'Signup successful.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end  
      
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if current_user.is_not_member?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @user = User.find(params[:id])
    
    if @user != current_user && current_user.is_not_council?
      flash[:error] = "You do not have permissions to edit other users."
      redirect_to root_path and return
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if current_user.is_not_council?
      flash[:error] = "You do not have permissions to access that feature."
      redirect_to root_path and return
    end
    
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
    
  def myfav
    @favs = Favorite.where(:user_id => current_user.id)

  end  
end
