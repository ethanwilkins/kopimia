class UsersController < ApplicationController
  def connections
    # page for people, groups, and federations of user
    @user = User.find(params[:user_id])
  end
  
  def following
    reset_page
    @user = User.find(params[:id])
    @users = paginate @user.followed_users
  end
  
  def new
    @user = User.new
    Activity.log_action(current_user, request.remote_ip.to_s, "users_new")
  end
  
  def create
    @user = User.new(params[:user].permit(:email, :password, :password_confirmation, :name))
    @user.ip = request.remote_ip.to_s
    
    if @user.save
      user = User.last
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      cookies.permanent[:logged_in_before] = true
      Activity.log_action(current_user, request.remote_ip.to_s, "users_create")
      redirect_to root_url
    else
      flash[:error] = "No fields can be empty."
      Activity.log_action(nil, request.remote_ip.to_s, "users_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    user_id = @user.id
    if current_user and @user.destroy
      session[:user_id] = nil
      flash[:notice] = "Your account was successfully deleted."
      redirect_to root_url
    else
      flash[:error] = "There was a problem deleting your account."
      redirect_to :back
    end
  end
  
  def settings
    @user = current_user
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    if @user.update(params[:user].permit(:profile_picture,
      :bio, :name, :private, :color_theme))
      redirect_to @user
    else
      flash[:error] = "Invalid input. Username may already be in use."
      redirect_to :back
    end
  end
  
  def show
    reset_page
    # gets user and feed based on page
    @user = User.find(params[:id])
    @posts = paginate @user.posts
    @post = Post.new
    # finds a message folder if one exists
    if @user != current_user and Folder.folder_between(current_user, @user)
      @folder = Folder.folder_between(current_user, @user)
    end
  end
  
  def index
    reset_page
    @users = paginate User.all
  end
end
