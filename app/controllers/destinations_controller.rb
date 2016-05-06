class DestinationsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

  def index
    @destinations = Destination.all
  end

  def new
    @destination = Destination.new
    @destination.trips.build(:user_id => current_user.id)

  end

  def create
    @destination = Destination.new(destination_params)
    if @destination.save
      redirect_to @destination
    else
      render :new
    end
  end

  def show
    @destination = Destination.find(params[:id])
  end

  private

  def destination_params
    params.require(:destination).permit(:city, :id, :trips_attributes => [:trip_nickname, :start_date, :end_date, :user_id])
  end

end