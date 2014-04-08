# the chats view has to know if a chat exists between the users
# whether to send message to existing chat or make a new one
# such logic in a partial 

class ChatsController < ApplicationController
  def index
  end

  def show
  end
  
  def new
    @chat = Chat.new
    @message = Message.new
  end
  
  def create
    @user = User.find(params[:user_id])
    # start chat between current user and other user
    @chat = current_user.chats.new(params[:chat].permit(:members, :topic)) # throws unkown attr
    @chat.creator = current_user
    if @chat.save
      # send message to user and the new chat
      @user.message!(current_user, params[:message].permit(:text), @chat)
      redirect_to user_chat_path(current_user, @chat)
    end
  end
end
