# gotta use gravatar for profile pictures, validate presence of email in user creation

class UsersController < ApplicationController
  
  # http_basic_authenticate_with name: "admin", password: "pass", only: :destroy

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.followed_users
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user].permit(:name, :password, :email, :bio))
    
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
    @post = Post.new
  end
  
  def index
    @users = User.all
  end
end
