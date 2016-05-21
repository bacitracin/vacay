class DestinationsController < ApplicationController
 before_action :authenticate_user!, except: [:index, :show] #check this
 # is this the correct before filter I want?

 # Users can see all destinations, esp to get new ideas
  def index
    @destinations = Destination.all
  end 

  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.find_or_create_by(destination_params) # No dupes created
    if @destination.valid?
      @destination.save
      flash[:notice] = "Destination successfully created" # !!!check that this doesn't show when it already exists
      redirect_to @destination # if found/created successfully, show the page
    else
      render :new
    end
  end

  # Users can see all individual destination pages
  def show 
    @destination = Destination.find(params[:id])
  end

  # Anybody can edit the spelling of the destination city 
  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params) # !!!! CHECK WHAT THE UPDATE FUNCTION DOES
      flash[:notice] = "Destination successfully updated"
      redirect_to @destination
    else
      flash[:notice] = "Destination can't be blank. Please try again."
      render :edit 
    end
  end

  def destroy
    Destination.find_by_id(params[:id]).destroy # maybe add in option/error if the trip cannot be found 
    flash[:notice] = "Destination was deleted" 
    redirect_to destinations_path 
  end

  private

  def destination_params
    params.require(:destination).permit(:city) # so far, only attribute is the city name
  end

end