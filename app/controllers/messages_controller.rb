class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.build(message_params)
    @message.sender = current_user

    if @message.save
      respond_to do |format|
        format.turbo_stream # Atualiza em tempo real
        format.html { redirect_to chat_path(@chat), notice: "Mensagem enviada!" }
      end
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
