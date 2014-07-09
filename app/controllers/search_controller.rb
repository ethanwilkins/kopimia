class SearchController < ApplicationController
  def search
    if params[:query]
      @users = User.where "name = ? OR name = ?", params[:query].capitalize, params[:query].downcase
      @groups = Group.where "name = ? OR name = ?", params[:query].capitalize, params[:query].downcase
      @tags = if params[:query].include? "#"
                Hashtag.tagged(params[:query].downcase)
              else
                Hashtag.tagged("#" + params[:query].downcase)
              end
      if @users.empty? and @groups.empty? and @tags.empty?
        @no_results = "No results were found."
      end
    end
  end
end
