class RestaurantsController < ApplicationController
	# Utility methods
	def restaurant_params
    params.require(:restaurant).permit(:name)
  end
	
	# GET
	def index
		@restaurants = Restaurant.all
  end

  # GET
  def new
  	@restaurant = Restaurant.new
  end

  # POST
  def create
  	Restaurant.create(restaurant_params)
  	redirect_to '/restaurants'
  end

  # GET
  def show
  	@restaurant = Restaurant.find(params[:id])
  end
  
end
