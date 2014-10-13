class MembersController < ApplicationController
  def request_to_join
    @group = Group.find(params[:id])
    @proposal = @group.proposals.create(user_id: current_user.id, action: "request_to_join")
    Activity.log_action(current_user, request.remote_ip.to_s,
      "request_to_join_group", @proposal.id)
    redirect_to :back
  end
  
  def index
    if params[:group_id]
      @group = Group.find(params[:group_id])
      @members = @group.members
      
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
      @groups = @federation.members
    end
    Activity.log_action(current_user, request.remote_ip.to_s,
      "members_page_visit")
  end
  
  def create
    @group = Group.find(params[:id])
    @group.members.create(user_id: current_user.id)
    Activity.log_action(current_user, request.remote_ip.to_s,
      "create_group_member", Member.last.id)
    redirect_to :back
  end
  
  def destroy
    @group = Group.find(params[:id])
    @membership = Member.find(@group.membership(current_user))
    @membership.destroy!
    Activity.log_action(current_user, request.remote_ip.to_s,
      "leave_group", @group)
    redirect_to :back
  end
end
