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
end
