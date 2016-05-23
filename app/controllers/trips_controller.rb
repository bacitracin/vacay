class TripsController < ApplicationController
   before_action :authenticate_user! #check this

   # trip is nested under user - user/1/trips/4
   # index is all of the user's trips. Doesn't really make sense for a user to see every freaking one's trip
  def index
    if params[:date] == "Upcoming"
      @trips = Trip.upcoming
    elsif params[:date] == "Past"
      @trips = Trip.past
    end
    # need to work on this
    @trips = current_user.trips
  end

  def new
    @trip = current_user.trips.build() # should i be using build or not? does build save to the db? 
  end

  def create
    @trip = current_user.trips.build(trip_params)
    # created 'destination_city custom attribute writer' in the trip model
    @destination = Destination.find_or_create_by(:city => params[:trip][:destination][:destination_city]) 
    @trip.destination_id = @destination.id 
    @destination.trips << @trip # Got to tell destination that trip belongs to it
    
    if @trip.valid?
      @trip.save
      # !!!check that this doesn't show when it already exists. you can create 2 trips with the same name, that's ok
      #flash[:notice] = "Trip successfully created" 
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
      redirect_to :index
    else
      @trip = Trip.find_by_id(params[:id])
      @destination = Destination.find_by_id(@trip.destination.id)
      if @trip.update(trip_params)
        @destination = Destination.find_or_create_by(:city => params[:trip][:destination][:destination_city])
        @trip.destination_id = @destination.id
        @destination.trips << @trip 
        redirect_to @trip
      else
        render :edit
      end
    end
   end

   def destroy
     Trip.find_by_id(params[:id]).destroy # can I change this from find_by_id to just find????
     flash[:notice] = "Trip was deleted" # maybe add in option/error if the trip cannot be found 
     redirect_to user_trips_path(current_user)
   end

   private

    def trip_params
      params.require(:trip).permit(:trip_nickname, :id, :start_date, :end_date, :destination_city) # do i need ID here??? don't think so
    end

end