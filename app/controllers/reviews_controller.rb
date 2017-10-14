class ReviewsController < ApplicationController

  before_filter :authorize

  def create
    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])
    @review.user = current_user
    @review.product = @product

    if @review.save!
      redirect_to :back, notice: 'Review created!'
    else
      render template: 'products/show'
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy!
    redirect_to :back, notice: 'Review deleted!'
  end



  private
  def review_params
    params.require(:review).permit( :description, :rating )
  end

end
