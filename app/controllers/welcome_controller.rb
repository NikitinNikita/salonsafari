class WelcomeController < ApplicationController
  def index
    # Get all users from database
    @users = User.all
	
	# Get all news from database ordered by added date
    news = News.all.order('created_at desc')
	
	# Get all sales from database ordered by added date 
    sales = Sale.all.order('created_at desc')
	
	# Get the first two news
    @first_news = news.first(2)
	
	# Get the first two sales
    @first_sales = sales.first(2)
	
    @is_empty_news = false # Flag that indicates if the news is empty
	
	# If the count of news is 0
    if @first_news.count == 0
	
	  # Then flag is true
      @is_empty_news = true
    end
    
    @is_empty_sales = false # Flag that indicates if the sales is empty
	
	# If the count of sales is 0
    if @first_sales.count == 0
	
	  # Then flag is true
      @is_empty_sales = true
    end
  end

  def about
    @users = User.all
  end

  # All the following methods are shows price page of corresponding service
  def affro
    @users = User.all
  end

  def chemicalperm
    @users = User.all
  end

  def contacts
    @users = User.all
  end

  def gallery
    @users = User.all
  end

  def haircare
    @users = User.all
  end

  def haircoloring
    @users = User.all
  end

  def haircut
    @users = User.all
  end

  def hairextension
    @users = User.all
  end

  def hairstyling
    @users = User.all
  end

  def makeup
    @users = User.all
  end

  def manicure
    @users = User.all
  end

  def service
    @users = User.all
  end
end
