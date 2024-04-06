class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @categories = Category.includes(:products)
  end

  def show
    @category = Category.includes(:products).find(params[:id])
    @products = @category.products
  end
end
