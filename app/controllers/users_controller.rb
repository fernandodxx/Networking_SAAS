class UsersController < ApplicationController
  before_action :authenticate_user!
  def profile
    render json: {
      user: {
        id: current_user.id,
        email: current_user.email,
        created_at: current_user.created_at.strftime("%d/%m/%Y"),
        last_sign_in_at: current_user.last_sign_in_at,
        total_connections: current_user.connected_users.count
      },
      interests: current_user.interests.map { |interest| interest.name },
      connections: current_user.connected_users.map { |user| { id: user.id, email: user.email } }
    }
  end

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def by_interest
    interest = Interest.find_by(name: params[:name])
    if interest
      render json: interest.users
    else
      render json: { error: "Interest not found" }, status: :not_found
    end
  end

  private

  def user_params
    params.expect(user: [ :name, :email ])
  end
end
