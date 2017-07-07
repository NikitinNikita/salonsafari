class SessionsController < ApplicationController
  def new
    @users = User.all
  end

  def create
  
	# Get all users form database
    @users = User.all
	
	# Find user by entered name
    user = User.find_by(name: params[:name])
	
	# If user is not null (nil) and authenticate is success
    if user and user.authenticate(params[:password])
	
	  # Add id of current user to session variable
      session[:user_id] = user.id
	  
	  # Redirect to Index page
      redirect_to index_url
    else
	
	  # Redirect to Login page with error
      redirect_to login_url#, alert: "Неверная комбинация имени и пароля"
    end
  end

  def destroy
  
	# Get all users form database
    @users = User.all
	
	# Set current user id in session as null (nil)
    session[:user_id] = nil
	
	# Redirect to Index page with notice
    redirect_to index_url#, notice: "Сеанс работы завершен"
  end
end
