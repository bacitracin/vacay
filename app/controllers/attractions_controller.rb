class AttractionsController < ApplicationController
  # Should I add validations???
  # currently no safeguard against duplication
  #also users can create attractions and add them on to trips that they do not own!!! s

  def index
    @attractions = Attraction.all
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @destination = Destination.find_or_create_by(:city => params[:attraction][:destination][:destination_city])
    @attraction = @destination.attractions.create(attraction_params) #why not build???

    @trip = Trip.find_or_create_by(:trip_nickname=> params[:attraction][:trip][:trip_nickname],:start_date=> params[:attraction][:trip][:start_date], :end_date=> params[:attraction][:trip][:end_date])
    @trip.destination_id = @destination.id
    @attraction.trips << @trip

    if @attraction.valid? # wait wtf, why not save???? 
      redirect_to @attraction
    else
      render :new
    end

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
    @trip = Trip.find_or_create_by(:trip_nickname=> params[:attraction][:trip][:trip_nickname],:start_date=> params[:attraction][:trip][:start_date], :end_date=> params[:attraction][:trip][:end_date])
    @attraction.trips << @trip
    if @attraction.update(attraction_params)
      flash[:notice] = "Attraction successfully updated"
      redirect_to @attraction
    else
      flash[:notice] = "Oops something went wrong. Please try again."
      render :edit 
    end
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



  

