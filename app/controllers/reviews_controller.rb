class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :find_review, only: [:show]
  before_action :find_like, only: [:destroy]


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

def show
  @like = @review.likes.find_by(user: current_user)
  redirect_to @review.product
end

private
def find_review
  @review = Review.find params[:id]
end

def find_like
  @like = Like.find(params[:id])
end



end
