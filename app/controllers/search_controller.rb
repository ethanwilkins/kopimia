class SearchController < ApplicationController
  def search
    if params[:query]
      @results = []
      @users = User.where "name = ? OR name = ?", params[:query].capitalize, params[:query].downcase
      @groups = Group.where "name = ? OR name = ?", params[:query].capitalize, params[:query].downcase
      @modules = CodeModule.where "name = ? OR name = ?", params[:query].capitalize, params[:query].downcase
      @tags = Hashtag.tagged(params[:query])
      
      @results << @users
      @results << @groups
      @results << @modules
      @results << @tags
      
      if params[:query] == ""
        @groups = Group.all
      elsif @users.empty? and @groups.empty? and @modules.empty? and @tags.empty?
        @no_results = "No results were found."
      end
    end
  end
end
