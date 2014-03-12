class UsersController < ApplicationController
  
  # http_basic_authenticate_with name: "admin", password: "pass", only: :destroy
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user].permit(:name, :password, :bio))
    
    if @user.save
      redirect_to @user
    else
      render 'register'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    redirect_to users_path
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.all
  end
end
