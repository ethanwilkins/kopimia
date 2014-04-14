class ChatsController < ApplicationController
  def index
    @chats = all_chats_for current_user
  end

  def show
    @user = User.find(params[:user_id])
    @chat = Chat.find(params[:id])
    @message = Message.new
  end
  
  def new
    @chat = Chat.new
    @message = Message.new
  end
  
  def create
    # build new chat and message between user
    @chat = current_user.chats.new(params[:chat].permit(:members, :topic))
    @message = @chat.messages.new(params[:message].permit(:text))
    @message.sender = current_user.id
    @chat.members << current_user.name
    @chat.user = current_user
    # verify that both are saved
    if @chat.save and @message.save
      # show the new chat to current user
      redirect_to user_chat_path(current_user, @chat)
    end
  end
end
