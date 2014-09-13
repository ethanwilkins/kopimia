class SharesController < ApplicationController
  def up_vote
    @share = Share.find(params[:id])
    Vote.up_vote!(@share, current_user)
    User.find(@share.user_id).notify!(:up_vote, current_user, @share.id)
    redirect_to :back
  end
  
  def down_vote
    @share = Share.find(params[:id])
    Vote.down_vote!(@share, current_user)
    redirect_to :back
  end
  
  def create
    @group = Group.find(params[:group_id])
    @share = @group.shares.new(params[:share].permit(:name, :description, :good, :service, :image))
    @share.user_id = current_user.id
    
    if @share.save
      flash[:notice] = "The share was successfully posted."
      redirect_to group_shares_path(@group)
    else
      flash[:error] = "Invalid input."
      redirect_to :back
    end
  end
  
  def show
    @share = Share.find(params[:id])
  end
  
  def index
    @share = Share.new
    @group = Group.find(params[:group_id])
    @shares = @group.shares.all.reverse
  end
end
