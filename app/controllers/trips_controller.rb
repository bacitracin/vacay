class TripsController < ApplicationController
   before_action :find_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = current_user.trips

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @trips }
    end

  end

  def new
    @trip = current_user.trips.build() 
  end

  def create
    @trip = current_user.trips.build(trip_params)
    # created 'destination_city custom attribute writer' in the trip model
    @destination = Destination.find_or_create_by(:city => params[:trip][:destination][:destination_city]) 
    @trip.destination = @destination
    
    if @trip.valid?
      @trip.save
      redirect_to @trip
      
    else
     render :new
     end

  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @trip }
    end
  end

  def edit
    if @trip.user_id != current_user.id
      flash[:notice] = "Sorry you can only edit your own trips"
      redirect_to user_trips_path(current_user)
    else
      find_destination
    end
  end

  def update
    if @trip.user_id != current_user.id
      flash[:notice] = "Sorry you can only edit your own trips"
      redirect_to user_trips_path(current_user)
    else
      find_destination
      if @trip.update(trip_params)
        # will create dupes instead of changing the destination object for everyone
        @destination = Destination.find_or_create_by(:city => params[:trip][:destination][:destination_city])  
        @trip.destination = @destination
        @destination.trips << @trip
        redirect_to @trip
      else
        render :edit
      end
    end
   end

  def destroy
    if @trip.user_id != current_user.id
      flash[:notice] = "Sorry you can only delete your own trips"
      redirect_to user_trips_path(current_user)
    else
      @trip.destroy 
      flash[:notice] = "Trip was deleted"
      redirect_to user_trips_path(current_user)
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:trip_nickname, :start_date, :end_date, :destination_city) 
  end

  def find_trip
    @trip = Trip.find_by_id(params[:id])
  end

  def find_destination
    @destination = Destination.find_by_id(@trip.destination.id)
  end

end