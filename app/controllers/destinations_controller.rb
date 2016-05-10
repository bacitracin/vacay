class DestinationsController < ApplicationController
# before_action :authenticate_user!, except: [:index, :show]

  def index
     @destinations = Destination.all
  end

  def new
    @destination = Destination.new
    @trip = @destination.trips.build(:user_id => current_user.id, :destination_id => @destination.id)
  end

  # def create
  #   @destination = Destination.new(destination_params)
  #   if @destination.save
  #     redirect_to @destination
  #   else
  #     render :new
  #   end
  # end

  # def show
  #    @destination = Destination.find(params[:id])
  # end

  # def edit
  #   @destination = Destination.find(params[:id])
  # end

  # def update
  #   if @destination.update(destination_params)
  #     redirect_to @destination
  #   else
  #     render :edit
  #   end
  # end

   # def destroy
   #   Destination.find_by_id(params[:id]).destroy

   #   redirect_to destinations_path
   # end

   # private

  # def destination_params
  #   params.require(:destination).permit(:city, :id, :trips_attributes => [:trip_nickname, :start_date, :end_date, :user_id])
  # end

end