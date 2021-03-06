class Admin::RestaurantsController < Admin::BaseController
  before_action :set_restaurant, only:[:show, :edit, :update, :destroy]
  
  def index
    #@restaurants = Restaurant.all
    #use Kaminari page
    @restaurants = Restaurant.order(created_at: :desc).page(params[:page]).per(10)
    @page = params[:page]
    if !@page
      @page = "1"
     end
  end


  def new
    @restaurant = Restaurant.new
  end

  def create

    @restaurant = Restaurant.new(restaurant_params)
    if ! Restaurant.where('lower(name) = ?', @restaurant.name.downcase).first
      if @restaurant.save
        flash[:notice] = "Restaurant was successfully created"
        redirect_to admin_restaurants_path
      else
        flash.now[:alert] = "Rastaurant was failed to create"
        render :new
      end
    else
        flash[:alert] = "Rastaurant was already exist"
        render :new
    end
  end

  def show
    
  end


  def edit

  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "Restaurant was successfully updated"
      redirect_to admin_restaurant_path(@restaurant)
    else
      flash.now[:alert] = "Rastaurant was failed to update"
      render :edit
    end
  end 

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path
    flash[:alert] = "Restaurant was deleted"

  end


  private

  def restaurant_params
    params.require(:restaurant).permit(:name,
                                      :opening_hours,
                                      :tel,
                                      :address,
                                      :description,
                                      :image,
                                      :category_id
                                      )
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
