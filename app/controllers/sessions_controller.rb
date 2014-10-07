class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:error] = "Invalid email or password"
      redirect_to :back
    end
    Activity.log_action(current_user, request.remote_ip.to_s, "log_in")
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
