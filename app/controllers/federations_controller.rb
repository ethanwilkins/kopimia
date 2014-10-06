class FederationsController < ApplicationController
  def show
    @federation = Federation.find(params[:id])
    @groups = @federation.members
    Activity.log_action(current_user, request.remote_ip.to_s,
      "federation_page_visit", @federation.id)
  end
  
  def index
    @federations = Federation.all
  end
end
