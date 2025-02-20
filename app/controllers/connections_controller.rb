class ConnectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @connections = current_user.connections
  end

  def create
    user = User.find(params[:user_id])
    connected_user = User.find(params[:connected_user_id])

    if user == connected_user
      return render json: { error: "You cannot connect to yourself" }, status: :unprocessable_entity
    end

    if user.connected_users.include?(connected_user)
      return render json: { error: "You are already connected to this user" }, status: :unprocessable_entity
    end

    connection = Connection.new(user: user, connected_user: connected_user)

    if connection.save
      render json: connection, status: :created
    else
      render json: connection.errors, status: :unprocessable_entity
    end
  end

  def user_connections
    user = User.find(params[:user_id])
    render json: user.connected_users
  end

  def destroy
    connection = current_user.connections.find(params[:id])
    connection.destroy
    redirect_to connections_path, notice: "Conexão removida!"
  end

  private

  def connection_params
    params.expect(connection: [ :user_id, :connected_user_id ])
  end
end
