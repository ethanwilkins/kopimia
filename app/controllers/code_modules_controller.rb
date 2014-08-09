require 'uri'

class CodeModulesController < ApplicationController
  def show
    @module = CodeModule.find(params[:id])
    @is_a_link = true if @module.code =~ /\A#{URI::regexp}\z/
  end
  
  def index
    @group = Group.find(params[:group_id])
    @modules = @group.code_modules.all.reverse
  end
end
