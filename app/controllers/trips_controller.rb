class TripsController < ApplicationController
   before_action :authenticate_user! #check this
   # trip is nested under user - user/1/trips/4

  def index #add in these two model methods, # need to work on this
    if params[:date] == "Upcoming"
      @trips = Trip.upcoming
    elsif params[:date] == "Past"
      @trips = Trip.past
    end
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
    @trip = Trip.find_by_id(params[:id])
  end

  # Users can only edit their own trips
  def edit
    if Trip.find_by_id(params[:id]).user_id != current_user.id
      flash[:notice] = "Sorry you can only edit your own trips"
      redirect_to user_trips_path(current_user)
    else
      @trip = Trip.find_by_id(params[:id])
      @destination = Destination.find_by_id(@trip.destination.id)
    end
  end

  def update
    if Trip.find_by_id(params[:id]).user_id != current_user.id
      flash[:notice] = "Sorry you can only edit your own trips"
      redirect_to user_trips_path(current_user)
    else
      @trip = Trip.find_by_id(params[:id])
      @destination = Destination.find_by_id(@trip.destination.id)
      if @trip.update(trip_params)
        @destination.update(:city => params[:trip][:destination][:destination_city])
        redirect_to @trip
      else
        render :edit
      end
    end
   end

  def destroy
    Trip.find_by_id(params[:id]).destroy 
    flash[:notice] = "Trip was deleted" # maybe add in option/error if the trip cannot be found 
    redirect_to user_trips_path(current_user)
  end

  private

  def trip_params
    params.require(:trip).permit(:trip_nickname, :start_date, :end_date, :destination_city) 
  end

end