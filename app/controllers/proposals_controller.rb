class ProposalsController < ApplicationController
  def menu
    if params[:group_id]
      @group = Group.find(params[:group_id])
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
    end
    Activity.log_action(current_user,
      request.remote_ip.to_s, "proposal_menu_page_visit")
  end
  
  def up_vote
    @proposal = Proposal.find(params[:id])
    Vote.up_vote!(@proposal, current_user)
    # ratifies proposal at enough votes
    if @proposal.ratify
      Activity.log_action(current_user, request.remote_ip.to_s,
        "proposal_up_vote", @proposal.id)
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
    Activity.log_action(current_user, request.remote_ip.to_s,
      "proposal_down_vote", @proposal.id)
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
    Activity.log_action(current_user, request.remote_ip.to_s,
      "proposal_page_visit", @proposal.id)
  end
  
  def index
    if params[:group_id]
      @group = Group.find(params[:group_id])
      @proposals = @group.proposals.sort_by(&:score).reverse!
      
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
      @proposals = @federation.proposals.sort_by(&:score).reverse!
    end
    Activity.log_action(current_user,
      request.remote_ip.to_s, "proposals_page_visit")
  end
  
  def create
    if params[:group_id]
      @group = Group.find(params[:group_id])
      _obj = @group
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
      _obj = @federation
    end
    @proposal = _obj.proposals.new(params[:proposal].permit(:submission, :federated_federation_id,
      :description, :icon, :anonymous, :item_name, :federated_group_id, :why))
    @proposal.user_id = params[:user_id] unless params[:anonymous] == 1
    @proposal.action = session[:proposal_type]
    if @proposal.save
      @proposal.ratify if @group and @group.members.size < 2
      Activity.log_action(current_user, request.remote_ip.to_s,
        "create_proposal", @proposal.id)
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
    @federations = Federation.all
    @proposal = Proposal.new
    @groups = Group.all
    Activity.log_action(current_user,
      request.remote_ip.to_s, "new_proposal_page_visit")
  end
end
