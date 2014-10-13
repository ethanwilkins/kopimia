# followed hashtags should add to post score

class HashtagsController < ApplicationController
  def tagged
    @tags = Hashtag.tagged(params[:tag])
    Activity.log_action(current_user, request.remote_ip.to_s,
      "tagged", @hashtag.id)
  end
  
  def follow
    @hashtag = Hashtag.find(params[:id])
    @hashtag.follow(current_user)
    Activity.log_action(current_user, request.remote_ip.to_s,
      "hashtag_follow", @hashtag.id)
    redirect_to tagged_path(@hashtag.tag)
  end
end
