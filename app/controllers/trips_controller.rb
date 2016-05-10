class TripsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @trips = current_user.trips
  end

  def new
    @trip = current_user.trips.build()
  end

    def create
      @trip = current_user.trips.build(trip_params)
      @destination = Destination.find_or_create_by(:city => params[:trip][:destination][:destination_city])
      @trip.destination_id = @destination.id
      @destination.trips << @trip
      if @trip.valid?
        @trip.save
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
     redirect_to user_trips_path
   end

   private

    def trip_params
      params.require(:trip).permit(:trip_nickname, :id, :start_date, :end_date, :destination_city)
    end

end