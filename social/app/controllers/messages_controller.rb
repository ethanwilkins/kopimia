class MessagesController < ApplicationController
  
  def index
  end

  def show
  end
  
  def new
  end
  
  # called from within chats#show
  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.new(params[:message].permit(:text))
    @message.sender = current_user.id
    @user = @chat.user
    if @message.save
      redirect_to user_chat_path(@user, @chat)
    end
  end
end
