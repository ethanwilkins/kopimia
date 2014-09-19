class FederationsController < ApplicationController
  def show
    @federation = Federation.find(params[:id])
    @groups = @federation.members
  end
  
  def index
    @federations = Federation.all
  end
end
