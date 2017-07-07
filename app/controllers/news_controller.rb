class NewsController < ApplicationController
  skip_before_action :authorize, only: [:index]
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  require 'securerandom'

  # GET /news
  # GET /news.json
  def index
  
	# Get all news ordered by added date
	# paginate method is used to split all news by pages with 3 notes
    @news = News.order('created_at desc').paginate(:page => params[:page], :per_page => 3)
    @users = User.all
  end

  # GET /news/1
  # GET /news/1.json
  def show
    # Get all users from database
    @users = User.all

	# If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end
  end

  # GET /news/new
  def new
    # Get all news form database
    @news = News.new
	
	# Get all users from database
    @users = User.all

	# If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end
  end

  # GET /news/1/edit
  def edit
   # Get all users from database
    @users = User.all

	# If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end
  end

  # POST /news
  # POST /news.json
  def create
    # Get all users from database
    @users = User.all

	# If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end
	
	# Create news with params
    @news = News.new(news_params)

	# Get uploaded file path
    uploaded_file = @news.image_path

	# Get file name of uploaded image
    filename = @news.image_path.original_filename
	
	# Set path to image of created news to recieved file name
    @news.image_path = filename

	# Get type of file
    content_type = uploaded_file.content_type
	
	# Get bytes of uploaded file
    data = uploaded_file.read
	
	# Save file to app/assets/images directory with original file name
    File.open(Rails.root.join('app', 'assets', 'images', filename), 'wb') do|f|
        f.write(data)
    end

    respond_to do |format|
      if @news.save
        format.html { redirect_to news_index_url, notice: 'News was successfully created.' }
        format.json { render action: 'show', status: :created, location: @news }
      else
        format.html { render action: 'new' }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    # Get all users from database
    @users = User.all

	# If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end
	
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to news_index_url, notice: 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
	# Get all users from database
    @users = User.all

	# If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end

    File.delete(Rails.root.join('app', 'assets', 'images', @news.image_path))
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_index_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:title, :description, :image_path)
    end
end
