class FoldersController < ApplicationController
  def index
    @folders = Folder.inbox_of(current_user)
  end
  
  def new
    session[:receiver] = params[:user_id]
    @message = Message.new
  end

  def show
    session[:receiver] = params[:user_id]
    @folder = Folder.find(params[:id])
    @message = Message.new
    @messages = @folder.messages
  end
end
