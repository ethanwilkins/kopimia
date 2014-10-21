class UsersController < ApplicationController
  def connections
    # page for people, groups, and federations of user
    @user = User.find(params[:user_id])
  end
  
  def following
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
    
    @user = User.find(params[:id])
    @users = @user.followed_users.reverse.
      # drops first several posts if :feed_page
      drop((session[:page] ? session[:page] : 0) * page_size).
      # only shows first several posts of resulting array
      first(page_size)
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
      Activity.log_action(current_user,
        request.remote_ip.to_s, "create_user")
      redirect_to root_url
    else
      flash[:error] = "No fields can be empty."
      Activity.log_action(nil, request.remote_ip.to_s, "create_user_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    user_id = @user.id
    if @user.destroy
      session[:user_id] = nil
      flash[:notice] = "Your account was successfully deleted."
      Activity.log_action(nil, request.remote_ip.to_s, "destroy_user", user_id)
      redirect_to root_url
    else
      flash[:error] = "There was a problem deleting your account."
      Activity.log_action(current_user,
        request.remote_ip.to_s, "destroy_user_fail")
      redirect_to :back
    end
  end
  
  def settings
    @user = current_user
    Activity.log_action(current_user,
      request.remote_ip.to_s, "settings_page_visit")
  end
  
  def edit
    @user = current_user
    Activity.log_action(current_user,
      request.remote_ip.to_s, "edit_page_visit")
  end
  
  def update
    @user = current_user
    
    if @user.update(params[:user].permit(:profile_picture,
      :bio, :name, :private, :color_theme))
      Activity.log_action(current_user,
        request.remote_ip.to_s, "update_user")
      redirect_to @user
    else
      flash[:error] = "Invalid input. Username may already be in use."
      Activity.log_action(current_user,
        request.remote_ip.to_s, "update_user_fail")
      redirect_to :back
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
