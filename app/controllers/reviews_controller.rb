class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)

    @review.user = current_user

    if @review.save!
      redirect_to :back, notice: 'Review created!'
    else
      render :new
    end
  end



  private
  def review_params
    params.require(:review).permit(
      :product_id,
      :user_id,
      :description,
      :rating
    )
  end
end
