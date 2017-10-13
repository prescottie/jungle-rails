class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)

    if @product.save!
      redirect_to "product_path", notice: 'Review created!'
    else
      render :new
    end
  end



  private
  def product_params
    params.require(:review).permit(
      :product_id,
      :user_id,
      :description,
      :rating
    )
  end
end
