class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.order(created_at: :desc).page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end
end
