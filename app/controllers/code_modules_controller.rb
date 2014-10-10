require 'uri'

class CodeModulesController < ApplicationController
  def show
    @module = CodeModule.find(params[:id])
    @is_a_link = true if @module.code =~ /\A#{URI::regexp}\z/
    Activity.log_action(current_user, request.remote_ip.to_s,
      "code_module_page_visit", @module.id)
  end
  
  def index
    if params[:group_id]
      @group = Group.find(params[:group_id])
      @modules = @group.code_modules.all.reverse
    elsif params[:federation_id]
      @federation = Federation.find(params[:federation_id])
      @modules = @federation.code_modules.all.reverse
    end
    Activity.log_action(current_user, request.remote_ip.to_s,
      "code_modules_page_visit", @module.id)
  end
end
