class FriendshipsController < ApplicationController
  
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      flash[:notice] = "Successfully be Friend"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship.destroy
    flash[:alert] = "Friendship destroyed, we are not friend anymore."
    redirect_back(fallback_location: root_path)
  end
end