class CategoriesController < ApplicationController
  def show
    @category = Category.includes(:products).find(params[:id])
    @products = @category.products
  end
end
