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
    @message = @user.messages.create(params[:message].permit(:text, :sender))
    redirect_to @user
  end
end
