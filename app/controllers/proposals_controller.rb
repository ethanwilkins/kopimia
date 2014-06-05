class ProposalsController < ApplicationController
  
  def up_vote
    @proposal = Proposal.find(params[:id])
    @members = Group.find(@proposal.group_id).members
    Vote.up_vote!(@proposal, current_user)
    if @proposal.votes.up_votes.size > @members.size / 2 and @members.size > 2
      @proposal.update inactive: true
      case @proposal.action
        when "icon_change"
          @proposal.icon_change
      end
    end
    redirect_to :back
  end
  
  def down_vote
    @proposal = Proposal.find(params[:id])
    Vote.down_vote!(@proposal, current_user)
    redirect_to :back
  end
  
  def request_to_join
    @group = Group.find(params[:id])
    @proposal = @group.proposals.create(user_id: current_user.id, action: "request_to_join")
    redirect_to :back
  end
  
  def show
    @group = Group.find(params[:group_id])
    @proposal = Proposal.find(params[:id])
    @comment = Comment.new
  end
  
  def index
    @group = Group.find(params[:group_id])
    @proposals = @group.proposals.reverse
  end
  
  def create
    @group = Group.find(params[:group_id])
    @proposal = @group.proposals.new(params[:proposal].permit(:action, :title, :description, :icon))
    if @proposal.save
      redirect_to group_path(@group)
    else
      redirect_to :back
    end
  end
  
  def destroy
    @group = Group.find(params[:group_id])
    @proposal = @group.proposals.find(params[:id])
    @proposal.destroy
    redirect_to group_proposals_path(@group)
  end
  
  def new
    @proposal = Proposal.new
  end
end
