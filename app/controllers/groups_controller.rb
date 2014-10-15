class GroupsController < ApplicationController
  def groups_joined
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
    
    @user = User.find(params[:id])
    @groups = Group.groups_of(@user).
        # drops first several posts if :feed_page
        drop((session[:page] ? session[:page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
    Activity.log_action(current_user, request.remote_ip.to_s,
      "user_groups_joined_page_visit")
  end
  
  def federations
    @group = Group.find(params[:group_id])
    @federations = @group.federations
    Activity.log_action(current_user, request.remote_ip.to_s,
      "groups_federations_page_visit", @group.id)
  end
  
  def index
    if current_user
      # resets to front at refresh
      unless session[:more]
        session[:page] = nil
      end
      session[:more] = nil
      # gets groups based on page_size
      @groups = Group.groups_of(current_user).sort_by(&:posts_plus_members).reverse.
        # drops first several posts if :page
        drop((session[:page] ? session[:page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
    end
    # logs the visit with the contextual data
    Activity.log_action(current_user,
      request.remote_ip.to_s, "groups_page_visit")
  end
  
  def new
    @group = Group.new
    Activity.log_action(current_user, request.remote_ip.to_s,
      "new_group_page_visit", @group.id)
  end
  
  def create
    @group = Group.new(params[:group].permit(:name, :description, :icon, :private))
    
    if @group.save
      @group.members.create(user_id: current_user.id)
      flash[:notice] = "The group was created successfully."
      Activity.log_action(current_user, request.remote_ip.to_s,
        "group_create", @group.id)
      redirect_to @group
    else
      flash[:error] = "The group could not be created."
      Activity.log_action(current_user, request.remote_ip.to_s,
        "group_create_fail")
      redirect_to :back
    end
  end
  
  def show
    # resets back to front page at refresh
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
    # gets group and feed based on page
    @group = Group.find(params[:id])
    @feed = @group.posts.sort_by(&:score).reverse.
      # drops first several posts if :feed_page
      drop((session[:page] ? session[:page] : 0) * page_size).
      # only shows first several posts of resulting array
      first(page_size)
    @post = Post.new
    # logs the visit with the contextual data
    Activity.log_action(current_user, request.remote_ip.to_s,
      "group_page_visit", @group.id)
  end
end
