class GroupsController < ApplicationController
  def groups_joined
    @groups = Group.groups_of(params[:id])
  end
  
  def index
    @groups = Group.groups_of(current_user).reverse
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
    @group = Group.find(params[:id])
    @feed = @group.posts.sort_by(&:score).reverse!
    @post = Post.new
  end
end
