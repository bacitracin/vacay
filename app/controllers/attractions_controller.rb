class AttractionsController < ApplicationController

  def index
    @attractions = Attraction.all
  end

  def new
    @attraction = Attraction.new
  end

  def create
    if (params[:attraction][:destination][:destination_city]) == ""
      @attraction = Attraction.create(attraction_params) #create so form is prefilled
      render :new
    else
      @destination = Destination.find_or_create_by(:city => params[:attraction][:destination][:destination_city])
      @attraction = @destination.attractions.create(attraction_params) #not sure if i want to change this to get rid of dupe
      if @attraction.valid?
        redirect_to @attraction
      else
        render :new
      end
    end

   # separate out trip association into set_trip 
   # @trip = Trip.find_or_create_by(:trip_nickname=> params[:attraction][:trip][:trip_nickname])
   # @trip.destination_id = @destination.id
   # @attraction.trips << @trip
  end

  def show
    @attraction = Attraction.find_by_id(params[:id])
  end

  def edit
    @attraction = Attraction.find_by_id(params[:id])
    @destination = @attraction.destination
  end
  
  def update
    @attraction = Attraction.find_by_id(params[:id])
    @destination = @attraction.destination

    if @attraction.update(attraction_params)
      @destination.update(:city => params[:attraction][:destination][:destination_city])
      flash[:notice] = "Attraction details successfully updated"
      redirect_to @attraction
    else
      flash[:notice] = "Oops something went wrong. Please try again."
      render :edit 
    end
  end


  #### CHECK THIS #####
  def set_trip
    @attraction = Attraction.find_by_id(params[:id])
    @destination = @attraction.destination
    @trip = Trip.find_or_create_by(params[:trip])
    @trip.destination_id = @destination.id
    @trip.attractions << @attraction
    redirect_to @trip
  end

  def destroy
    Attraction.find_by_id(params[:id]).destroy
    flash[:notice] = "Attraction was deleted"
    redirect_to user_trips_path(current_user)
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :url, :attraction_type, :destination_city, :trip_nickname)
  end

end


  

