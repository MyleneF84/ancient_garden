class PagesController < ApplicationController
  def home
    @categories = Category.all
    @home = true
  end
end
