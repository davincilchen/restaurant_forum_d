class RestaurantsController < ApplicationController

  before_action :set_restaurant, only:[:show, :dashboard, :favorite, :unfavorite]

  def index
    @restaurants = Restaurant.order(created_at: :desc).page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @comment = Comment.new
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end


  def dashboard

  end

  # POST /restaurants/:id/favorite
  def favorite
    @restaurant.favorites.create!(user: current_user)
    #@restaurant.favorites.create!(user_id: current_user.id)
    #Favorite.create(restaurant: @restaurant, user: current_user)
    #current_user.favorites.create(restaurant: @restaurant)
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end


  # POST /restaurants/:id/unfavorite
  def unfavorite
    favorite = Favorite.where(restaurant: @restaurant, user: current_user)

    if favorite.destroy_all

    end
    redirect_back(fallback_location: root_path)
  end


  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
