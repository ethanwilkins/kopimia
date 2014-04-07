class MessagesController < ApplicationController
  
  def index
  end

  def show
  end
  
  def new
  end
  
  def create
    @user = User.find(params[:id])
    # find chat if it exists
    @chat = @user.chat_with(current_user)
    # test if chat exists
    if @chat == nil
      # start new chat otherwise
      @chat = current_user.start_chat(params[:topic], @user.name)
    end
    # send message to user and the correct chat
    @user.message!(current_user, params[:message].permit(:text), @chat)
  end
end
