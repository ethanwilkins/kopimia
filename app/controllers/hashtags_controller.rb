# followed hashtags should add to post score

class HashtagsController < ApplicationController
  def tagged
    @tags = Hashtag.tagged(params[:tag]) if params[:tag]
  end
  
  def follow
    @hashtag = Hashtag.find(params[:id])
    @hashtag.follow(current_user)
    redirect_to tagged_path(@hashtag.tag)
  end
  
  def search
    if params[:query]
      @tags = if params[:query].include? "#"
                Hashtag.tagged(params[:query].downcase)
              else
                Hashtag.tagged("#" + params[:query].downcase)
              end
      if @tags.empty?
        @no_results = "No results were found."
      end
    end
  end
end
