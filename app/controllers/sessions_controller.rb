class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      user.update ip: request.remote_ip.to_s
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:error] = "Invalid email or password"
      redirect_to :back
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
