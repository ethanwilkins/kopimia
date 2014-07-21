class ProposalsController < ApplicationController
  def up_vote
    @proposal = Proposal.find(params[:id])
    Vote.up_vote!(@proposal, current_user)
    # ratifies proposal at enough votes
    @proposal.ratify
    redirect_to :back
  end
  
  def down_vote
    @proposal = Proposal.find(params[:id])
    Vote.down_vote!(@proposal, current_user)
    redirect_to :back
  end
  
  def show
    @group = Group.find(params[:group_id])
    @proposal = Proposal.find(params[:id])
    @comment = Comment.new
  end
  
  def index
    @group = Group.find(params[:group_id])
    @proposals = @group.proposals.sort_by(&:score).reverse!
  end
  
  def create
    @group = Group.find(params[:group_id])
    @proposal = @group.proposals.new(params[:proposal].permit(:action, :submission,
      :description, :icon, :anonymous))
      @proposal.user_id = params[:user_id] unless params[:anonymous] == 1
    if @proposal.save
      redirect_to group_proposals_path(@group)
    else
      flash[:error] = "You didn't choose a proposal type." if params[:proposal][:action].empty?
      redirect_to :back
    end
  end
  
  def new
    @proposal = Proposal.new
  end
end
