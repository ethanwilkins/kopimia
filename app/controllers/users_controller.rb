class UsersController < ApplicationController

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
    @user = User.new(params[:user].permit(:email, :password, :name))
    
    if @user.save
      user = User.last
      # maybe potentially be unsecure
      session[:user_id] = user.id if user
      redirect_to root_url
    else
      render "new"
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    if @user.update(params[:user].permit(:profile_picture, :bio))
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.reverse.
        # drops first several posts if :feed_page
        drop((session[:user_page] ? session[:user_page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
    @post = Post.new
  end
  
  def index
    @users = User.all
  end
end
