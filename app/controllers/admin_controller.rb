class AdminController < ApplicationController
  skip_before_action :authorize
  require 'digest/md5'
  

  def index
  end

  def index_post
  
    # Get entered password by user
	password = params[:password]
	
	# Calcualte MD5 Hash by entered password to check if the password entered coorectly
	md5_password = Digest::MD5.hexdigest(password)
	
	@is_success = false # Flag that indicates whether the user entered the password correctly
	
	if md5_password == '13dd91944ff12bc3387dd3cc3efacd4b' # If calculated MD5 Hash is equal to reference value
	
		@is_success = true # If password is correct then assign flag value as true 
		
	end

	# Memorize flag value into the session
	session[:is_success] = @is_success

	# Redirect user to Index page
	redirect_to index_path
  end
end
