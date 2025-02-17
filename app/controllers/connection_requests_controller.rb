class ConnectionRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    receiver = User.find(params[:receiver_id])
    request = ConnectionRequest.create(sender: current_user, receiver: receiver, status: "pending")

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: "Convite enviado!" }
      format.json { render json: request, status: :created }
    end
  end



  # Aceitar um convite
  def accept
    request = ConnectionRequest.find(params[:id])
    if request.receiver == current_user && request.status == "pending"
      request.update(status: "accepted")
      current_user.connected_users << request.sender
      request.sender.connected_users << current_user
      render json: { message: "Connection accepted" }, status: :ok
    else
      render json: { error: "Invalid request" }, status: :unprocessable_entity
    end
  end

  # Recusar um convite
  def decline
    request = ConnectionRequest.find(params[:id])
    if request.receiver == current_user && request.status == "pending"
      request.update(status: "declined")
      render json: { message: "Connection declined" }, status: :ok
    else
      render json: { error: "Invalid request" }, status: :unprocessable_entity
    end
  end

  # Listar convites pendentes
  def pending_requests
    requests = current_user.received_requests.where(status: "pending")
    render json: requests
  end
end
