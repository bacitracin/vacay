class AttractionsController < ApplicationController

  before_action :find_attraction, only: [:show, :edit, :update, :destroy]

  def index
    @attractions = Attraction.all

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @attractions }
    end
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.create(attraction_params)
    @destination = Destination.find_or_create_by(:city => params[:attraction][:destination][:destination_city])
    @attraction.destination = @destination
   
    if (params[:attraction][:trip][:trip_nickname]) == ""
      @trip = "N/A" # Don't save trip
    else
      @trip = current_user.trips.find_or_create_by(:trip_nickname=> params[:attraction][:trip][:trip_nickname])
      @trip.destination = @destination
      @attraction.trips << @trip
    end
      
    if @attraction.valid?
      @attraction.save
      #redirect_to @attraction
      render json: @attraction, status: 201
    else
      render :new
    end

  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @attraction }
    end
  end

  def edit
  end
  
  def update
    @destination = Destination.find_or_create_by(:city => params[:attraction][:destination][:destination_city]) unless (params[:attraction][:destination][:destination_city]) == ""
    @attraction.update(attraction_params)
    @attraction.destination = @destination

    if (params[:attraction][:trip][:trip_nickname]) == "" || (params[:attraction][:trip][:trip_nickname]) == "N/A"
      @trip = "N/A"
    else
      @trip = current_user.trips.find_or_create_by(:trip_nickname=> params[:attraction][:trip][:trip_nickname])
      @trip.destination = @destination
      @attraction.trips << @trip
    end

    if @attraction.valid?
      flash[:notice] = "Attraction details successfully updated"
      redirect_to @attraction
    else
      flash[:notice] = "Something went wrong. Please try again."
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


  

