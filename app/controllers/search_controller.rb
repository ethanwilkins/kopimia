class SearchController < ApplicationController
  def search
    if params[:query]
      @users = User.where "name = ? OR name = ?", params[:query].capitalize, params[:query].downcase
      @groups = Group.where "name = ? OR name = ?", params[:query].capitalize, params[:query].downcase
      if @users.size < 1 and @groups.size < 1
        @no_results = "No results were found."
      end
    end
  end
end
