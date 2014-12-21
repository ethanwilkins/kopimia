class GroupsController < ApplicationController
  def groups_joined
    reset_page
    @user = User.find(params[:id])
    @groups = Group.groups_of(@user).
        # drops first several posts if :feed_page
        drop((session[:page] ? session[:page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
  end
  
  def federations
    @group = Group.find(params[:group_id])
    @federations = @group.federations
  end
  
  def index
    if current_user
      reset_page
      session[:more] = nil
      # gets groups based on page_size
      @groups = paginate Group.groups_of(current_user).sort_by(&:rank)
    end
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(params[:group].permit(:name, :description, :icon, :private))
    
    if @group.save
      @group.members.create(user_id: current_user.id)
      flash[:notice] = "The group was created successfully."
      redirect_to @group
    else
      flash[:error] = "The group could not be created."
      redirect_to :back
    end
  end
  
  def show
    reset_page
    session[:more] = nil
    # gets group and feed based on page
    @group = Group.find(params[:id])
    @feed = paginate @group.posts.sort_by(&:score)
    @post = Post.new
  end
end
