class ProposalsController < ApplicationController
  def menu
    if params[:group_id]
      @group = Group.find(params[:group_id])
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
    elsif params[:proposal_id]
      @proposal = Proposal.find(params[:proposal_id])
    end
  end
  
  def new
    session[:proposal_type] = params[:proposal_type] if params[:proposal_type].present?
    @_proposal = Proposal.find_by_id(params[:proposal_id]) # the old proposal being changed
    @federations = Federation.all
    @proposal = Proposal.new
    @groups = Group.all
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
      @proposals = @group.proposals.where(ratified: nil).sort_by(&:score).reverse!
      
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
    elsif params[:proposal_id]
      @proposal = Proposal.find(params[:proposal_id])
      _obj = @proposal
    end
    @new_proposal = _obj.proposals.new(params[:proposal].permit(:submission, :federated_federation_id,
      :description, :icon, :anonymous, :item_name, :federated_group_id, :why))
    @new_proposal.user_id = params[:user_id] unless params[:anonymous] == 1
    @new_proposal.action = session[:proposal_type]
    if @new_proposal.save
      @new_proposal.ratify if @group and @group.members.size < 2
      if @group
        if Group.find_by_id(@group.id)
          redirect_to group_proposals_path(@group)
        else
          redirect_to groups_path
        end
      elsif @federation
        if Federation.find_by_id(@federation.id)
          redirect_to federation_proposals_path(@federation)
        else
          redirect_to root_url
        end
      elsif @proposal
        if @proposal.group_id
          redirect_to group_proposal_path(Group.find(@proposal.group_id), @proposal)
        elsif @proposal.federation_id
          redirect_to federation_proposal_path(Federation.find(@proposal.federation_id), @proposal)
        end
      end
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
end
