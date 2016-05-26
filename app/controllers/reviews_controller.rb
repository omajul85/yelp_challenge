class ReviewsController < ApplicationController
	before_action :authenticate_user!

  # Utility methods
	def review_params
  	params.require(:review).permit(:thoughts, :rating)
  end

	def new
  	@restaurant = Restaurant.find(params[:restaurant_id])
  	@review = Review.new
  end

  def create
  	@restaurant = Restaurant.find(params[:restaurant_id])
  	@review = @restaurant.reviews.build_with_user(review_params, current_user)

    if @review.save
      redirect_to '/restaurants'
    else
      flash.now[:notice] = "Field cannot be blank"
      render 'new'
    end
  end

end
