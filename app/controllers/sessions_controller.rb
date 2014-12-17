class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      user.update_token if user.auth_token.nil?
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      cookies.permanent[:logged_in_before] = true
      Activity.log_action(current_user, request.remote_ip.to_s, "sessions_create")
      redirect_to root_url
    else
      flash[:error] = "Invalid email or password"
      Activity.log_action(nil, request.remote_ip.to_s, "sessions_create_fail")
      redirect_to :back
    end
  end

  def destroy
    current_user.update_token
    cookies.delete(:auth_token)
    flash[:notice] = "Log out successful."
    redirect_to root_url
  end
end
