class MessagesController < ApplicationController
  
  def index
  end

  def show
  end
  
  def new
  end
  
  def create
    # get user of the page
    @user = User.find(params[:id])
    # find chat with current user
    @chat = @user.chat_with(current_user)
    # send message to user and the correct chat
    @user.message!(current_user, params[:message].permit(:text), @chat)
  end
end
