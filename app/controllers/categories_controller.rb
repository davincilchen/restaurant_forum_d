class CategoriesController < ApplicationController

  def show
    @categories = Category.all
    @category = Category.find(param[:id])
    @restaurants = @category.restaurants.page(param[:page]).per(9)

  end
end
