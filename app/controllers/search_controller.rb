class SearchController < ApplicationController
  def search
    session[:query] = params[:query]
    if session[:query]
      @query = session[:query]
      @users = User.where "name = ? OR name = ?", session[:query].capitalize, session[:query].downcase
      @groups = Group.where "name = ? OR name = ?", session[:query].capitalize, session[:query].downcase
      @modules = CodeModule.where "name = ? OR name = ?", session[:query].capitalize, session[:query].downcase
      @tags = Hashtag.tagged(session[:query])

      
      if session[:query] == ""
        @groups = Group.all
      elsif @users.empty? and @groups.empty? and @modules.empty? and @tags.empty?
        @no_results = "No results were found."
      end

      @all_results = []
      @users.any? { |user| @all_results << user }
      @groups.any? { |group| @all_results << group }
      @modules.any? { |_module| @all_results << _module }
      @tags.any? { |tag| @all_results << tag }
      
      @results = @all_results.
        # drops first several posts if :feed_page
        drop((session[:page] ? session[:page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
    end
    # logs the visit with the contextual data
    Activity.log_action(current_user, request.remote_ip.to_s, "search", nil, @query)
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
  end
end
