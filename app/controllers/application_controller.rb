class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  @users = User.all

  Dir.glob("#{Rails.root}/app/assets/images/**/").each do |path|
    Rails.application.config.assets.paths << path
  end

end
