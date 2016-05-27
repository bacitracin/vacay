class AttractionsController < ApplicationController

  before_action :find_attraction, only: [:show, :edit, :update, :destroy]

  def index
    @attractions = Attraction.all
  end

  def new
    @attraction = Attraction.new
  end

  def create
    if (params[:attraction][:destination][:destination_city]) == ""
      @attraction = Attraction.create(attraction_params) #go ahead and create so form is prefilled for other fields
      @trip = current_user.trips.find_or_create_by(:trip_nickname=> params[:attraction][:trip][:trip_nickname])
      render :new
    else
      @destination = Destination.find_or_create_by(:city => params[:attraction][:destination][:destination_city])
      @attraction = @destination.attractions.create(attraction_params) #not sure if i want to change this to get rid of dupe
      if (params[:attraction][:trip][:trip_nickname]) == ""
        @trip = "N/A" #if there's no trip nickname just have blank for now
      else
        @trip = current_user.trips.find_or_create_by(:trip_nickname=> params[:attraction][:trip][:trip_nickname])
        @trip.destination_id = @destination.id
        @destination.trips << @trip
        @attraction.trips << @trip
      end
      
      if @attraction.valid?
        redirect_to @attraction
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end
  
  def update
    if @attraction.update(attraction_params)
      if (params[:attraction][:destination][:destination_city]) == ""
        render :edit
      else
        @destination = Destination.find_or_create_by(:city => params[:attraction][:destination][:destination_city]) #creating dupe instead of overwriting
        @attraction.destination_id = @destination.id
        @destination.attractions << @attraction
      end
      if (params[:attraction][:trip][:trip_nickname]) == ""
        @trip = "N/A" #if there's no trip nickname just have blank for now
      else
        @trip = Trip.find_or_create_by(:trip_nickname=> params[:attraction][:trip][:trip_nickname])
        @trip.destination_id = @destination.id
        @attraction.trips << @trip
        flash[:notice] = "Attraction details successfully updated"
     end
     redirect_to @attraction
    else
      flash[:notice] = "Oops something went wrong. Please try again."
      render :edit 
    end
  end

  def destroy
    @attraction.destroy
    flash[:notice] = "Attraction was deleted"
    redirect_to user_trips_path(current_user)
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :url, :attraction_type, :destination_city, :trip_nickname)
  end

  def find_attraction
    @attraction = Attraction.find_by_id(params[:id])
    @destination = @attraction.destination
  end

end


  

