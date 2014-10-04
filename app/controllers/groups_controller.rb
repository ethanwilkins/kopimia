class GroupsController < ApplicationController
  def groups_joined
    @user = User.find(params[:id])
    @groups = Group.groups_of(@user)
  end
  
  def federations
    @group = Group.find(params[:group_id])
    @federations = @group.federations
  end
  
  def index
    @groups = Group.groups_of(current_user).sort_by(&:posts_plus_members).reverse if current_user
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(params[:group].permit(:name, :description, :icon, :private))
    
    if @group.save
      @group.members.create(user_id: current_user.id)
      redirect_to @group
    else
      render "new"
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
  end
end
