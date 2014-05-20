class GroupsController < ApplicationController
  
  def request_to_join
    # adds to a list of requests to be voted on
  end
  
  def join
    @group = Group.find(params[:id])
    @group.members.create(user_id: current_user.id)
    redirect_to :back
  end
  
  def leave
    @group = Group.find(params[:id])
    @membership = Member.find(@group.membership(current_user))
    @membership.destroy!
    redirect_to :back
  end
  
  def index
    @groups = Group.my_groups(current_user)
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(params[:group].permit(:name, :description, :icon, :private))
    
    if @group.save
      redirect_to @group
    else
      render "new"
    end
  end
  
  def show
    @group = Group.find(params[:id])
  end
end
