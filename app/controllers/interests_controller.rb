class InterestsController < ApplicationController
  def index
    @interests = Interest.all
    render json: @interests
  end

  def create
    @interest = Interest.new(interest_params)
    if @interest.save
      render json: @interest, status: :created
    else
      render json: @interest.errors, status: :unprocessable_entity
    end
  end

  private

  def interest_params
    params.expect(interest: [ :name ])
  end
end
