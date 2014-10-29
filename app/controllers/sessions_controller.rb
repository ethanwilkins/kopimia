class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      Activity.log_action(current_user, request.remote_ip.to_s, "sessions_create")
      redirect_to root_url
    else
      flash[:error] = "Invalid email or password"
      Activity.log_action(nil, request.remote_ip.to_s, "sessions_create_fail")
      redirect_to :back
    end
  end

  def destroy
    user_id = session[:user_id]
    session[:user_id] = nil
    Activity.log_action(nil, request.remote_ip.to_s, "sessions_destroy", user_id)
    redirect_to root_url
  end
end
