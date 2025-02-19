class InterestsController < ApplicationController
  def index
    @interests = Interest.all
    render json: @interests
  end

  def create
    current_user.interests.create(name: params[:name])

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: "Interesse adicionado!" }
      format.turbo_stream
    end
  end

  def destroy
    interest = current_user.interests.find(params[:id])
    interest.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: "Interesse removido!" }
      format.turbo_stream
    end
  end
end
