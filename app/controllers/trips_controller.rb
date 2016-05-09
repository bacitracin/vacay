class TripsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new(:user_id => current_user.id)
    @destination = @trip.build_destination()
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to @trip
    else
      render :new
    end
  end

  def show
    @trip = Trip.find_by_id(params[:id])
  end

  def edit
    @trip = Trip.find_by_id(params[:id])
  end

  def update
    if @trip.update(trip_params)
      redirect_to @trip
    else   
      render :edit
    end
  end

  def destroy
    Trip.find_by_id(params[:id]).destroy
    redirect_to trips_path
  end


  def trip_params
    params.require(:trip).permit(:trip_nickname, :id, :start_date, :end_date, :destination)
  end

end