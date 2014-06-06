class SearchController < ApplicationController
  def search
    if params[:query]
      @users = User.where "name = ? or name = ?", params[:query].capitalize, params[:query].downcase
      @groups = Group.where "name = ? or name = ?", params[:query].capitalize, params[:query].downcase
    end
  end
end
