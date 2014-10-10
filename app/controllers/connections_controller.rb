class ConnectionsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    @user.notify!(:follow, current_user)
    current_user.follow!(@user)
      Activity.log_action(current_user, request.remote_ip.to_s,
        "follow", @user.id)
    redirect_to @user
  end

  def destroy
    @user = Connection.find(params[:id]).followed
    current_user.unfollow!(@user)
      Activity.log_action(current_user, request.remote_ip.to_s,
        "unfollow", @user.id)
    redirect_to @user
  end
end
