class SharesController < ApplicationController
  def up_vote
    @share = Share.find(params[:id])
    if Vote.up_vote!(@share, current_user)
      User.find(@share.user_id).notify!(:up_vote_share, current_user, @share.id)
      @share.add_to_reputation
      redirect_to :back
    else
      redirect_to :back
    end
  end
  
  def down_vote
    @share = Share.find(params[:id])
    Vote.down_vote!(@share, current_user)
    redirect_to :back
  end
  
  def new
    @share = Share.new
  end
  
  def create
    if params[:group_id]
      @group = Group.find(params[:group_id])
      _obj = @group
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
      _obj = @federation
    end
    @share = _obj.shares.new(params[:share].permit(:name,
      :description, :good, :service, :image, :open))
    @share.user_id = current_user.id
    
    if @share.save
      flash[:notice] = "The share was successfully posted."
      if @group
        redirect_to group_shares_path(@group)
      elsif @federation
        redirect_to federation_shares_path(@federation)
      end
    else
      flash[:error] = "Invalid input."
      redirect_to :back
    end
  end
  
  def show
    if params[:group_id]
      @group = Group.find(params[:group_id])
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
    end
    @share = Share.find(params[:id])
    @comments = @share.comments
    @comment = Comment.new
  end
  
  def index
    if params[:group_id]
      @group = Group.find(params[:group_id])
      @shares = @group.shares.all.reverse
      
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
      @shares = @federation.shares.all.reverse
    end
  end
end
