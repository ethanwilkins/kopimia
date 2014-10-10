class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      Activity.log_action(current_user, request.remote_ip.to_s, "log_in", user.id)
      redirect_to root_url
    else
      flash[:error] = "Invalid email or password"
      Activity.log_action(current_user, request.remote_ip.to_s, "log_in_fail")
      redirect_to :back
    end
  end

  def destroy
    user_id = session[:user_id]
    session[:user_id] = nil
    Activity.log_action(current_user, request.remote_ip.to_s, "log_out", user_id)
    redirect_to root_url
  end
end
