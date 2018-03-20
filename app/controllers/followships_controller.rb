class FollowshipsController < ApplicationController

  def create
    # 需要設定前端的 link_to，在發出請求時送進 following_id
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "Successfully followed"
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    # where 會回傳物件集合(Array)，如果有需要串接可取出單一物件的方法如 first
    @followship = current_user.followships.where(following_id: params[:id])
    if @followship.size == 0
      flash[:alert] = "No followship for user is destroyed"
    else
      @followship.destroy_all
      flash[:alert] = "Followship destroyed"
    end
    redirect_back(fallback_location: root_path)
  end
end
