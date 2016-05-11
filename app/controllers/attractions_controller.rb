class AttractionsController < ApplicationController

  def index
    @attractions = Attraction.all
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.create(attraction_params)

    @destination = Destination.find_or_create_by(:city => params[:attraction][:destination][:destination_city])
    @attraction.destination_id = @destination.id

    @trip = Trip.find_or_create_by(:trip_nickname=> params[:attraction][:trip][:trip_nickname])
    @attraction.trips << @trip

    if @attraction.valid?
      @attraction.save
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
  end
  
  def update
    @attraction = Attraction.find_by_id(params[:id])
    if @attraction.update(attraction_params)
      flash[:notice] = "Attraction successfully updated"
      redirect_to @attraction
    else
      render :edit 
      flash[:notice] = "Oops somethign went wrong. Please try again."
    end
  end

  def destroy
    Attraction.find_by_id(params[:id]).destroy
    flash[:notice] = "Attraction was deleted"
    redirect_to user_trips_path(current_user)
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name,:url, :attraction_type, :destination_city, :trip_nickname)
  end

end



  

