class ConnectionsController < ApplicationController
  def index
    @connections = Connection.all
    render json: @connections
  end

  def create
    @connection = Connection.new(connection_params)
    if @connection.save
      render json: @connection, status: :created
    else
      render json: @connection.errors, status: :unprocessable_entity
    end
  end

  private

  def connection_params
    params.expect(connection: [ :user_id, :connected_user_id ])
  end
end
