class DestinationsController < ApplicationController

  def index
    @destinations = Destination.all
  end

  def new
    @destination = Destination.new
    @trip = @destination.trips.build()
  end

  def create
    raise params.inspect
    @destination = Destination.create(destination_params)
    redirect_to @destination
  end

  def show
    @destination = Destination.find(params[:id])
  end

  private

  def destination_params
    params.require(:destination).permit(:city, :id, :trip_params => [:trip_nickname, :start_date, :end_date])
  end

end