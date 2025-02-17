class UserInterestsController < ApplicationController
  before_action :authenticate_user!

  def create
    interest = Interest.find_or_create_by(name: params[:name])
    current_user.interests << interest unless current_user.interests.include?(interest)
    render json: current_user.interests, status: :created
  end

  def destroy
    interest = current_user.interests.find_by(name: params[:name])
    if interest
      current_user.interests.delete(interest)
      render json: { message: "Interest removed successfully" }, status: :ok
    else
      render json: { error: "Interest not found" }, status: :not_found
    end
  end

  def index
    render json: current_user.interests
  end
end
