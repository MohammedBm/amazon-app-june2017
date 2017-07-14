class ReviewsController < ApplicationController

  def create
  @product = Product.find params[:product_id]
  @review = @product.reviews.build(params.require(:review).permit(:body, :rating))
  @review.user = current_user
  if @review.save
    redirect_to product_path(@product)
  else
    @review = @product.reviews.all.order(created_at: :desc)
    render 'products/show'
  end
end

def destroy
  review = Review.find(params[:id])
  review.destroy
  redirect_to product_path(review.product)
end



end
