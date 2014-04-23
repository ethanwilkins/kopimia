class MessagesController < ApplicationController
  
  def index
    @messages = current_user.messages
  end

  def show
    @message = Message.find(params[:id])
  end
  
  def new
    @user = User.find(params[:user_id])
    @message = Message.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @message = @user.messages.new(params[:message].permit(:text))
    @message.sender = params[:sender]
    
    if @message.save
      redirect_to @user
    else
      render "messages/new"
    end
  end
end
