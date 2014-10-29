class FederationsController < ApplicationController
  def show
    @federation = Federation.find(params[:id])
    @activities = @federation.relevant_activity
  end
  
  def index
    @federations = Federation.all
  end
end
