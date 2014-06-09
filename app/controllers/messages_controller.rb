class MessagesController < ApplicationController
  def create
    @receiver = User.find(session[:receiver])
    # saves message to new folder or old if existing
    if Folder.folder_between(current_user, @receiver)
      @folder = Folder.find(Folder.folder_between(current_user, @receiver))
    else
      @folder = Folder.new
      if @folder.save
        @folder.members.create(user_id: current_user.id)
        @folder.members.create(user_id: @receiver.id)
      end
    end
    @message = @folder.messages.new(params[:message].permit(:text))
    @message.user_id = current_user.id
    if @message.save
      @receiver.notify!(:message, current_user, @folder.id)
      redirect_to @folder
    else
      render "messages/new"
    end
  end
end