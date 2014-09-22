class ProposalsController < ApplicationController
  def menu
    if params[:group_id]
      @group = Group.find(params[:group_id])
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
    end
  end
  
  def up_vote
    @proposal = Proposal.find(params[:id])
    Vote.up_vote!(@proposal, current_user)
    # ratifies proposal at enough votes
    if @proposal.ratify
      flash[:notice] = "The proposal has been ratified!"
      if Proposal.where(id: @proposal.id).present?
        redirect_to :back
      else
        redirect_to groups_path
      end
    else
      redirect_to :back
    end
  end
  
  def down_vote
    @proposal = Proposal.find(params[:id])
    Vote.down_vote!(@proposal, current_user)
    redirect_to :back
  end
  
  def show
    if params[:group_id]
      @group = Group.find(params[:group_id])
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
    end
    @proposal = Proposal.find(params[:id])
    @comment = Comment.new
  end
  
  def index
    if params[:group_id]
      @group = Group.find(params[:group_id])
      @proposals = @group.proposals.sort_by(&:score).reverse!
      
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
      @proposals = @federation.proposals.sort_by(&:score).reverse!
    end
  end
  
  def create
    if params[:group_id]
      @group = Group.find(params[:group_id])
      _obj = @group
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
      _obj = @federation
    end
    @proposal = _obj.proposals.new(params[:proposal].permit(:submission,
      :description, :icon, :anonymous, :item_name, :federated_group_id))
    @proposal.user_id = params[:user_id] unless params[:anonymous] == 1
    @proposal.action = session[:proposal_type]
    if @proposal.save
      if @group
        redirect_to group_proposals_path(@group)
      elsif @federation
        redirect_to federation_proposals_path(@federation)
      end
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def new
    session[:proposal_type] = params[:proposal_type] if params[:proposal_type].present?
    @proposal = Proposal.new
    @groups = Group.all
  end
end
