class Admin::DashboardController < Admin::BaseController

  def index
    @products = Product.all
    @users = User.all
    @reviews = Review.all
  end

end
