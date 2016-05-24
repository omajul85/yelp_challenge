class ReviewsController < ApplicationController
	# Utility methods
	def review_params
  	params.require(:review).permit(:thoughts, :rating)
  end

	def new
  	@restaurant = Restaurant.find(params[:restaurant_id])
  	@review = Review.new
  end

  def create
  	p @restaurant = Restaurant.find(params[:restaurant_id])
  	@restaurant.reviews.create(review_params)
  end

end
