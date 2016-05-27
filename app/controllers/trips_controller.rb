class TripsController < ApplicationController
   before_action :authenticate_user!
   before_action :find_trip, only: [:show, :edit, :update, :destroy]

  def index #add in these two model methods, # need to work on this
   # if params[:date] == "Upcoming"
   #   @trips = Trip.upcoming_trips
   # elsif params[:date] == "Past"
   #   @trips = Trip.past_trips
   # end
    @trips = current_user.trips
  end

  def new
    @trip = current_user.trips.build() 
  end

  def create
    @trip = current_user.trips.build(trip_params)
    # created 'destination_city custom attribute writer' in the trip model
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

  # All trips are public
  def show
  end

  # Users can only edit their own trips
  def edit
    if @trip.user_id != current_user.id
      flash[:notice] = "Sorry you can only edit your own trips"
      redirect_to user_trips_path(current_user)
    else
      @destination = Destination.find_by_id(@trip.destination.id)
    end
  end

  def update
    if @trip.user_id != current_user.id
      flash[:notice] = "Sorry you can only edit your own trips"
      redirect_to user_trips_path(current_user)
    else
      @destination = Destination.find_by_id(@trip.destination.id)
      if @trip.update(trip_params)
        @destination = Destination.find_or_create_by(:city => params[:trip][:destination][:destination_city]) #creating dupes is better than changing the entire destination object for everyone 
        @trip.destination_id = @destination.id 
        @destination.trips << @trip
        redirect_to @trip
      else
        render :edit
      end
    end
   end

  def destroy
    @trip.destroy 
    flash[:notice] = "Trip was deleted" # maybe add in option/error if the trip cannot be found 
    redirect_to user_trips_path(current_user)
  end

  private

  def trip_params
    params.require(:trip).permit(:trip_nickname, :start_date, :end_date, :destination_city) 
  end

  def find_trip
    @trip = Trip.find_by_id(params[:id])
  end

end