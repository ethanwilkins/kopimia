class MessagesController < ApplicationController
  
  def index
  end

  def show
  end
  
  def new
  end
  
  # only called after checking chat_with from view
  def create
    # get user of the page
    @user = User.find(params[:id])
    # find chat with this user
    @chat = current_user.chat_with(@user)
    # send message to user and the correct chat
    @message = @chat.messages.new(params[:message].permit(:text))
    @message.sender = current_user.id
    if @message.save
      redirect_to user_chat_path(current_user, @chat)
  end
end
