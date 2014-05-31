class ProposalsController < ApplicationController
  
  def request_to_join
    @group = Group.find(params[:id])
    @proposal = @group.proposals.create(user_id: current_user.id, action: "request_to_join")
    redirect_to :back
  end
  
  def index
    @group = Group.find(params[:group_id])
    @proposals = @group.proposals
  end
  
  def create
    @group = Group.find(params[:group_id])
    @proposal = @group.proposals.new(params[:proposal].permit(:action, :text, :image))
    if @proposal.save
      redirect_to group_path(@group)
    else
      redirect_to :back
    end
  end
  
  def new
    @proposal = Proposal.new
  end
end
