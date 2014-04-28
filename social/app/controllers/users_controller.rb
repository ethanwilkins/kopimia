class UsersController < ApplicationController
  
  # http_basic_authenticate_with name: "admin", password: "pass", only: :destroy
  
  def search
    if params[:query]
      @users = User.find_by_sql("SELECT * FROM Users WHERE name = '#{params[:query]}'")
    end
  end

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
    @user.name.downcase!
    
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
    
    if @user.update(params[:user].permit(:profile_picture))
      redirect_to @user
    else
      render "edit"
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
