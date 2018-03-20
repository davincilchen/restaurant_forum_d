class FollowshipsController < ApplicationController

  def create
    puts "FollowshipsController ~~ create ~~"
    # 需要設定前端的 link_to，在發出請求時送進 following_id
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    puts "FollowshipsController ~~ destroy ~~"
  end
end
