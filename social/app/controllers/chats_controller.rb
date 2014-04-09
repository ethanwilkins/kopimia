# the chats view has to know if a chat exists between the users
# whether to send message to existing chat or make a new one
# such logic in a partial 

class ChatsController < ApplicationController
  def index
  end

  def show
    @chat = Chat.find(params[:id])
  end
  
  def new
    @chat = Chat.new
    @message = Message.new
  end
  
  def create
    @user = User.find(params[:user_id])
    # build new chat and message between user
    @chat = current_user.chats.new(params[:chat].permit(:members, :topic))
    @message = @chat.messages.new(params[:message].permit(:text))
    @message.sender = current_user.id
    # verify that both are saved
    if @chat.save and @message.save
      # show the new chat to current user
      redirect_to user_chat_path(current_user, @chat)
    end
  end
end
