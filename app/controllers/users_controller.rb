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
    Activity.log_action(current_user,
      request.remote_ip.to_s, "sign_up_page_visit")
  end
  
  def create
    @user = User.new(params[:user].permit(:email, :password, :name))
    @user.ip = request.remote_ip.to_s
    
    if @user.save
      user = User.last
      # maybe potentially be unsecure
      session[:user_id] = user.id if user
      redirect_to root_url
    else
      flash[:error] = "No fields can be empty."
      redirect_to :back
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      session[:user_id] = nil
      flash[:notice] = "Your account was successfully deleted."
      redirect_to root_url
    else
      flash[:error] = "There was a problem deleting your account."
      redirect_to :back
    end
  end
  
  def edit
    @user = current_user
    Activity.log_action(current_user,
      request.remote_ip.to_s, "edit_page_visit")
  end
  
  def update
    @user = current_user
    
    if @user.update(params[:user].permit(:profile_picture, :bio, :name, :private))
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def show
    # resets to front at refresh
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
    # gets user and feed based on page
    @user = User.find(params[:id])
    @posts = @user.posts.reverse.
        # drops first several posts if :feed_page
        drop((session[:page] ? session[:page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
    @post = Post.new
    # finds a message folder if one exists
    if @user != current_user and Folder.folder_between(current_user, @user)
      @folder = Folder.folder_between(current_user, @user)
    end
    # logs data about visit
    Activity.log_action(current_user, request.remote_ip.to_s,
      "user_profile_visit", @user.id)
  end
  
  def index
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
    
    @users = User.all.reverse.
      # drops first several posts if :feed_page
      drop((session[:page] ? session[:page] : 0) * page_size).
      # only shows first several posts of resulting array
      first(page_size)
      
    Activity.log_action(current_user,
      request.remote_ip.to_s, "users_page_visit")
  end
end
