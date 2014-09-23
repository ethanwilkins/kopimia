class SessionsController < ApplicationController
  def anon
    @anon = User.generate_anon
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now.alert = "Invalid email or password"
      render "welcome/index"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
