class FederationsController < ApplicationController
  def show
    @federation = Federation.find(params[:id])
    @groups = @federation.members
  end
  
  def index
    @group = Group.find(params[:id])
    @federations = @group.federations
  end
end
