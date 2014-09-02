class MessagesController < ApplicationController
  helper_method :decrypt_message
  
  def create
    @folder = Folder.find(params[:folder_id])
    @message = @folder.messages.new(params[:message].permit(:text))
    @message.user_id = current_user.id
    
    if @message.save
      @folder.notify_members(current_user)
      @folder.update updated_at: Time.now
      redirect_to @folder
    else
      flash[:error] = "Message did not send"
      redirect_to :back
    end
  end
  
  private
  
  def decrypt_message(message)
		key = ActiveSupport::KeyGenerator.new(message.created_at.to_s).generate_key(message.salt)
		encryptor = ActiveSupport::MessageEncryptor.new(key)
    message = encryptor.decrypt_and_verify(message.text)
    return message
  end
end