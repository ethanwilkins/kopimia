class ChatsController < ApplicationController
  def index
    @chats = all_chats_for current_user
  end

  def show
    @user = User.find(params[:user_id])
    @chat = Chat.find(params[:id])
  end
  
  def new
    @chat = Chat.new
  end
  
  def create
    @chat = current_user.chats.new(params[:chat].permit(:members, :topic))
    @chat.members << current_user.name
    @chat.user = current_user
    if @chat.save
      # show the new chat to current user
      redirect_to user_chat_path(current_user, @chat)
    end
  end
end
