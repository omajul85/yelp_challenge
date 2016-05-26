class RestaurantsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  
	# Utility methods
	def restaurant_params
    params.require(:restaurant).permit(:name, :description, :image)
  end
	
	# GET
	def index
		@restaurants = Restaurant.all.sort_by{ |r| r.name }
  end

  # GET
  def new
  	@restaurant = Restaurant.new
  end

  # POST
  def create
  	@restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to '/restaurants'
    else
      render 'new'
    end
  end

  # GET
  # This method gets called when you go to /restaurants/:restaurant_id, and uses the ID passed in the URL to look up the correct record from the database.
  def show
  	@restaurant = Restaurant.find(params[:id])
  end

  # GET
  def edit
  	@restaurant = Restaurant.find(params[:id])
  end

  # PATCH
  def update
  	@restaurant = Restaurant.find(params[:id])
  	@restaurant.update(restaurant_params)

  	redirect_to '/restaurants'
  end

  # DELETE/DESTROY
  def destroy
  	@restaurant = Restaurant.find(params[:id])
  	@restaurant.destroy
  	flash[:notice] = "Restaurant deleted succesfully"
  	
  	redirect_to '/restaurants'
  end

end
