class ConnectionsController < ApplicationController
  def index
    @connections = Connection.all
    render json: @connections
  end
end
