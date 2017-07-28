class ProductsController < ApplicationController
  before_action :authenticate_user!,only: [:new,:create,:edit,:update,:destroy]
  # before_action :find_product,only: [:show, :edit,:update,:destroy]
  before_action :find_like, only: [:destroy]
  # before_action :find_tag, only: [:show]
  def new
    @product = Product.new
  end


  def index
    @products = Product.order(created_at: :desc)
  end


  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find params[:id]
    @product.user = current_user
    product_params = params.require(:product).permit(:title, :body)


    if @product.update product_params
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find params[:id]
    if can? :destroy, @product
      @product.destroy
      flash[:notice] = "Product successfully deleted."
      redirect_to products_path
    else
      flash[:alert] = "Access Denied. You cannot delete a product that is not yours"
      redirect_to @product
    end
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      flash[:notice] = "Product created successfully"
      redirect_to product_path(@product)
   else
       flash[:alert] = "Problem creating your product"
      #  byebug
       render :new
    end
  end

  private

  def product_params
      params.require(:product).permit(:title, :description, :price, :category_id, :tag_list )
  end

  def find_like
    @like = Like.find(params[:id])
  end

  # def find_tag
  #   @tag = Tag.find(params[:id])
  # end
  #


end
