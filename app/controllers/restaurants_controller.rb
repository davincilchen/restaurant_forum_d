class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.order(created_at: :desc).page(params[:page]).per(9)
  end
end
