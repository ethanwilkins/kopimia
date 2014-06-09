class FoldersController < ApplicationController
  def index
    @folders = Folder.inbox_of(current_user)
  end
  
  def new
    @message = Message.new
    session[:receiver] = params[:user_id]
  end

  def show
    @messages = Folder.find(params[:id]).messages
    @message = Message.new
  end
end
