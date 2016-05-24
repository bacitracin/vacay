class DestinationsController < ApplicationController
 before_action :authenticate_user!, except: [:index, :show] 
 # is this the correct before filter I want?

  def index
    @destinations = Destination.all
  end 

  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.find_or_create_by(destination_params) 
    if @destination.valid?
      redirect_to @destination
    else
      render :new
    end
  end

  # Users can see all individual destination pages
  def show 
    @destination = Destination.find(params[:id])
  end

  # Anybody can edit the spelling of the destination city directly
  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params)
      flash[:notice] = "Destination successfully updated"
      redirect_to @destination
    else
      flash[:notice] = "Destination can't be blank. Please try again."
      render :edit 
    end
  end

  def destroy
    Destination.find_by_id(params[:id]).destroy #decide if i want to bother updating trips error
    flash[:notice] = "Destination was deleted" 
    redirect_to destinations_path 
  end

  private

  def destination_params
    params.require(:destination).permit(:city)
  end

end