class ProductsController < ApplicationController
  before_action :authenticate_user!,only: [:new,:create,:edit,:update,:destroy]
  # before_action :find_product,only: [:show, :edit,:update,:destroy]
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
    @product.destroy
    redirect_to products_path
  end


  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      flash[:notice] = "Product created successfully"
      redirect_to home_path
   else
       flash[:alert] = "Problem creating your product"
      render :new
    end
  end


  private

  def product_params
      params.require(:product).permit(:title, :description, :price, :category_id )
  end


end
