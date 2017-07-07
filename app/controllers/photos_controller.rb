class PhotosController < ApplicationController
  require 'fileutils'
  skip_before_action :authorize, only: [:index, :show]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
  
	# Get all users form databse
    @users = User.all
	
	# Get all photos from database
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  
	# Get all users form databse
    @users = User.all
  end

  # GET /photos/new
  def new
  
	# Get all users form databse
    @users = User.all
	
	# Create new photo
    @photo = Photo.new

    # If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end
  end

  # GET /photos/1/edit
  def edit
    # If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end
  end

  # POST /photos
  # POST /photos.json
  def create
  
	# Get all users form databse
    @users = User.all
	
    # If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end
	
	# Create new photo
    @photo = Photo.new(photo_params)

	# Get full path to app/assets/images/<name of current photo album> directory 
    path_to_dir = Rails.root.join('app', 'assets', 'images', @photo.name)    

	# Create directory with path_to_dir path
    FileUtils::mkdir_p path_to_dir

	# Get uploaded cover image
    uploaded_cover = @photo.cover

	# Get file name of uploaded image
    filename_cover = @photo.cover.original_filename
	
	# Set cover image to recieved file name
    @photo.cover = filename_cover

	# Get bytes of uploaded image
    data = uploaded_cover.read

	# Save file to app/assets/images/<name of current photo album> directory with original file name of cover
    File.open(Rails.root.join('app', 'assets', 'images', @photo.name, filename_cover), 'wb') do|f|
        f.write(data)
    end

    paths = "" # Variable that store paths to uploaded images
	
	# If uploaded files are not null (nil)
    if !params[ :files ].nil?

		# For each uploaded files
    	params[ :files ].each{ |file|
		
			# Get file name of uploaded image
			filename = file.original_filename
			
			# Concateate current path value with new path - recieved filename and ";" symbol to separate paths
    	    paths = paths + filename + ";"
			
			# Save recieved image to app/assets/images/<name of current photo album> directory with original file name of image
			File.open(Rails.root.join('app', 'assets', 'images', @photo.name, filename), 'wb') do|f|
				f.write(file.read)
			end
    	}
    end
  
   @photo.image_paths = paths[0...-1]

    respond_to do |format|
      if @photo.save
        format.html { redirect_to photos_url, notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
	
	# Get all users form databse
    @users = User.all
	
    # If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end

    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to photos_url, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    # Get all users form databse
    @users = User.all
	
    # If user not authorized
    if !session[:user_id]
		
		# Then redirect user to Index page
		redirect_to index_url
    end

	# Get all paths to images into this photo album
    photo_paths = @photo.image_paths.split(';')
	
	# For each image in album
    photo_paths.each{ |path_to_image|
	
		# Delete current image by filename from app/assets/images/<name of current photo album> directory
		File.delete(Rails.root.join('app', 'assets', 'images', @photo.name, path_to_image))
    }

	# Delete cover image
    File.delete(Rails.root.join('app', 'assets', 'images', @photo.name, @photo.cover))

	# Delete directory of current photo album
    FileUtils.rm_rf(Rails.root.join('app', 'assets', 'images', @photo.name))

    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  # Get method
  def add_photo_to_folder
  
	# Get current url
    url = request.original_url

	# Create new photo album
    @photo = Photo.new
   
	# Set photo_id in session as the symbol that locate after the last point in url
    session[:photo_id] = url.split('.').last()

	# Find photo album by calculated id
    photo = Photo.find_by(id: session[:photo_id])

    @id_photo = url.split('.').last()
	
  end
  
  # Post method
  def add_photo_to_folder_post

	# Find photo album by id in the session variable
    photo = Photo.find_by(id: session[:photo_id])

    # Get path to app/assets/images/<name of current photo album> directory
    path_to_folder = Rails.root.join('app', 'assets', 'images', photo.name)

	# Get all files from directory
    records = Dir.glob(path_to_folder.to_s + "/**/*" )

	# Memorize all photos in the album
    old_photos = photo.image_paths
    
    paths = "" # Variable that store paths to uploaded images
	
	# If uploaded files are not null (nil)
    if !params[ :files ].nil?
	
		# For each file
    	params[ :files ].each{ |file|
		
			# Get file name of uploaded image
			filename = file.original_filename
			
			# Get path to file that we want to add to album
			path_to_adding_file = Rails.root.join('app', 'assets', 'images', photo.name, filename).to_s
	     
			is_found = false # Flag tha indicates if file name was found
			
			# Get random value from 0 to 199 and transform it to string
			added_value = rand(0..199).to_s

			# For each file from directory of current photo album
			records.each { |exist_file|

				# If file with current file name allready exist in album
				if exist_file == path_to_adding_file
				
					# Set flag to true
					is_found = true
					
					# Generate new random value
					added_value = rand(0..199).to_s
					
					# While original file name not found
					while exist_file == Rails.root.join('app', 'assets', 'images', photo.name, added_value + '_' + filename).to_s
					
						# Generate new random value
						added_value = rand(0..199).to_s
					end
				end
			}
	     
			# If file is found
			if is_found
				
				# Set current file name to random value (integer) + '_' sybmol and + current file name
             	filename = added_value + '_' + filename
			end

			# If file name contains symbol "."
			if filename.to_s.include? "."
			
				# Then add current file name to paths variable (concatenate)
    	     	paths = paths + filename + ";"
			end

			# Write image to directory
			File.open(Rails.root.join('app', 'assets', 'images', photo.name, filename), 'wb') do|f|
				f.write(file.read)
			end
    	 }
    end

	# Concatenate memorized images in album with new images (except the last value of paths variable)
    photo.image_paths = old_photos + ";" + paths[0...-1]

	# Check if array still contains equal values
	
    is_bad = false # Flag that indicates if the array contains equal values
	
	# Get all images paths
    mass = photo.image_paths.split(';')
	
	# Create new array that contains just uniq values of old array
    new_array = mass.uniq
	
	# If th lengths of old and new array is not equal
    if mass.length != new_array.length
	
		# Set the flag value to true - array contains equal values
		is_bad = true
    end
    
	# If array contains just uniq values
    if !is_bad
	
		# Save photo album to database
    	photo.save
    else
		redirect_to comments_path_url
    end

    session[:photo_id] = -1
   
    redirect_to photos_url

  end

  # Get method
  def delete_photo_from_folder
  
	# Get current url
	url = request.original_url
	  
	# Set photo_id in session as the symbol that locate after the last point in url
	session[:photo_id] = url.split('.').last()
	
	# Find photo album by calculated id
	photo = Photo.find_by(id: session[:photo_id])
	
	# Get name of curretn photo album
	@photo_name = photo.name

	# Get all photos in album
	@list_of_photo = photo.image_paths.split(';')
	
  end

  # Post method
  def delete_photo_from_folder_post
	
	# Get current url
	url = request.original_url
	  
	# Get id of current photo
	i = url.split('.').last().to_i
	
	# Find photo album by calculated id
	photo = Photo.find_by(id: session[:photo_id])
	
	# Get all photos in album
	list_of_photos = photo.image_paths.split(';')

	# Get image by id (index of image in array)
	element = list_of_photos[i]
	
	# Delet file from app/assets/images/<name of current photo album> directory and recieved file name
	File.delete(Rails.root.join('app', 'assets', 'images', photo.name, element))	
	
	# Delete current photo from list of photo images
	list_of_photos.delete(element)

	# Update paths varibale to save it to database
	paths = ""
	list_of_photos.each { |item|
		paths = paths + item + ";"
	}

	# Iamges of current photo album is equal to paths variable except the last element
	photo.image_paths = paths[0...-1]

	# Save photo album to database
	photo.save

	redirect_to photos_url
	
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:name, :description, :image_paths, :cover)
    end
end
