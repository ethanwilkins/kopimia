class ProposalsController < ApplicationController
  def menu
    @group = Group.find(params[:group_id])
  end
  
  def up_vote
    @proposal = Proposal.find(params[:id])
    Vote.up_vote!(@proposal, current_user)
    # ratifies proposal at enough votes
    if @proposal.ratify
      flash[:notice] = "The proposal has been ratified."
    end
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
    @proposal = @group.proposals.new(params[:proposal].permit(:submission,
      :description, :icon, :anonymous, :module_name))
    @proposal.user_id = params[:user_id] unless params[:anonymous] == 1
    @proposal.action = session[:proposal_type]
    if @proposal.save
      redirect_to group_proposals_path(@group)
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def new
    session[:proposal_type] = params[:proposal_type] if params[:proposal_type].present?
    @proposal = Proposal.new
  end
end
