class TripsController < ApplicationController

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end


  private

  def trip_params
    params.require(:trip).permit(:trip_nickname, :start_date, :end_date, :destination_id)
  end
  #will need to set up Destination_name= like in Category Equals example
end