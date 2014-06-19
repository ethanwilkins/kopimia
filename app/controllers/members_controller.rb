class MembersController < ApplicationController
  
  def request_to_join
    @group = Group.find(params[:id])
    @proposal = @group.proposals.create(user_id: current_user.id, action: "request_to_join")
    redirect_to :back
  end
  
  def index
    @members = Group.find(params[:group_id]).members
  end
  
  def create
    @group = Group.find(params[:id])
    @group.members.create(user_id: current_user.id)
    redirect_to :back
  end
  
  def destroy
    @group = Group.find(params[:id])
    @membership = Member.find(@group.membership(current_user))
    @membership.destroy!
    redirect_to :back
  end
end
