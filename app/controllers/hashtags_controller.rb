class HashtagsController < ApplicationController
  def tagged
    @tags = Hashtag.tagged(params[:tag]) if params[:tag]
  end
end
