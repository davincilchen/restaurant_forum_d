class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update]


  def index
    @users = User.all
  end

  def show
    @commented_restaurants = @user.restaurants.uniq
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully update"
      redirect_to user_path
    else
      flash.now[:alert] = "User was failed to update"
      render :edit
    end
  end


  private


  def user_params
     params.require(:user).permit(:name, :introduction ,:avatar)
  end



  def set_user
    @user = User.find(params[:id])
  end

end
