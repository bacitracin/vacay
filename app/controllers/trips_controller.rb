class TripsController < ApplicationController
   before_action :authenticate_user!

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
     if Trip.find_by_id(params[:id]).user_id != current_user.id
      flash[:notice] = "Sorry you can only edit your own trips"
    else
      @trip = Trip.find_by_id(params[:id])
      @destination = Destination.find_by_id(@trip.destination.id)
    end

   end

   def update
    if Trip.find_by_id(params[:id]).user_id != current_user.id
      flash[:notice] = "Sorry you can only edit your own trips"
    else
      @trip = Trip.find_by_id(params[:id])
      @destination = Destination.find_by_id(@trip.destination.id)
      if @trip.update(trip_params)
        @destination = Destination.find_or_create_by(:city => params[:trip][:destination][:destination_city])
        @trip.destination_id = @destination.id
        @destination.trips << @trip 
        redirect_to @trip
      end
    end
   end

   def destroy
     Trip.find_by_id(params[:id]).destroy
     redirect_to user_trips_path(current_user)
   end

   private

    def trip_params
      params.require(:trip).permit(:trip_nickname, :id, :start_date, :end_date, :destination_city)
    end

end