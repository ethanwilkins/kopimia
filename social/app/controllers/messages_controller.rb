class MessagesController < ApplicationController
  
  def index
  end

  def show
  end
  
  def new
  end
  
  def create
    @user = User.find(params[:id])
    @user.message!(current_user, params[:message].permit(:text))
  end
end
