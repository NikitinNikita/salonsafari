class VacanciesController < ApplicationController
  skip_before_action :authorize, only: [:index]
  before_action :set_vacancy, only: [:show, :edit, :update, :destroy]

  # GET /vacancies
  # GET /vacancies.json
  def index
  
	# Get all users from database
    @users = User.all
	
	# Get all vacancies ordered by added date
    @vacancies = Vacancy.order('created_at desc')
  end

  # GET /vacancies/1
  # GET /vacancies/1.json
  def show
    # Get all users from database
    @users = User.all

    # If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end
  end

  # GET /vacancies/new
  def new
     # Get all users from database
    @users = User.all

    # If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end
	
	# Create new vacancy
    @vacancy = Vacancy.new
  end

  # GET /vacancies/1/edit
  def edit
     # Get all users from database
    @users = User.all

    # If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end
  end

  # POST /vacancies
  # POST /vacancies.json
  def create
    # Get all users from database
    @users = User.all

    # If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end

	# Create new vacancy with params
    @vacancy = Vacancy.new(vacancy_params)

    respond_to do |format|
      if @vacancy.save
        format.html { redirect_to vacancies_url, notice: 'Vacancy was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vacancy }
      else
        format.html { render action: 'new' }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vacancies/1
  # PATCH/PUT /vacancies/1.json
  def update
     # Get all users from database
    @users = User.all

    # If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end

    respond_to do |format|
      if @vacancy.update(vacancy_params)
        format.html { redirect_to vacancies_url, notice: 'Vacancy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacancies/1
  # DELETE /vacancies/1.json
  def destroy
     # Get all users from database
    @users = User.all

    # If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end

	# Delete current vacancy
    @vacancy.destroy
    respond_to do |format|
      format.html { redirect_to vacancies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacancy
      @vacancy = Vacancy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vacancy_params
      params.require(:vacancy).permit(:title, :description)
    end
end
