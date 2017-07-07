class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
  
	# Get all users from database
    @users = User.all
    
	# If user is not successfully authorized as admin
    if !session[:is_success]
	
		# Redirect to Index page
		redirect_to index_url
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    # Get all users from database
    @users = User.all
    
	# If user is not successfully authorized as admin
    if !session[:is_success]
	
		# Redirect to Index page
		redirect_to index_url
    end

  end

  # GET /users/new
  def new
  
	# Create new user
    @user = User.new
    
	# Get all users from database
    @users = User.all
    
	# If user is not successfully authorized as admin
    if !session[:is_success]
	
		# Redirect to Index page
		redirect_to index_url
    end

  end

  # GET /users/1/edit
  def edit
  
	# Get all users from database
    @users = User.all
    
    # If user is not successfully authorized as admin
    if !session[:is_success]
	
		# Redirect to Index page
		redirect_to index_url
    end

  end

  # POST /users
  # POST /users.json
  def create
  
	# Get all users from database
    @users = User.all
    
    # If user is not successfully authorized as admin
    if !session[:is_success]
	
		# Redirect to Index page
		redirect_to index_url
    end

	# Create new user with parameters
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
	# Get all users from database
    @users = User.all
    
    # If user is not successfully authorized as admin
    if !session[:is_success]
	
		# Redirect to Index page
		redirect_to index_url
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # Get all users from database
    @users = User.all
    
    # If user is not successfully authorized as admin
    if !session[:is_success]
	
		# Redirect to Index page
		redirect_to index_url
    end

	# Delete user from database
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
