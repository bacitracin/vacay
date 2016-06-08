class DestinationsController < ApplicationController

 before_action :find_destination, only: [:show, :edit, :update, :destroy]

  def index
    @destinations = Destination.all
  end 

  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.find_or_create_by(destination_params) 

    if @destination.valid?
      @destination.save 
      redirect_to @destination
    else
      render :new
    end

  end

  def show 
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @destination }
    end
  end

  def edit
  end

  def update
    if @destination.update(destination_params)
      flash[:notice] = "Destination successfully updated"
      redirect_to @destination
    else
      flash[:notice] = "Destination can't be blank. Please try again."
      render :edit 
    end
  end

  def destroy
    @destination.destroy
    flash[:notice] = "Destination was deleted" 
    redirect_to destinations_path 
  end

  private

  def destination_params
    params.require(:destination).permit(:city)
  end

  def find_destination
    @destination = Destination.find(params[:id])
  end

end