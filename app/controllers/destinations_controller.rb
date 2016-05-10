class DestinationsController < ApplicationController
 before_action :authenticate_user!, except: [:index, :show]

  def index
     @destinations = Destination.all
  end

  def new
    @destination = Destination.new
  end

   def create
     @destination = Destination.find_or_create_by(destination_params)
     if @destination.save
       redirect_to @destination
     else
       render :new
     end
   end

   def show
      @destination = Destination.find(params[:id])
   end

   def edit
     @destination = Destination.find(params[:id])
   end

   def update
     @destination = Destination.find(params[:id])
     if @destination.update(destination_params)
       flash[:notice] = "Destination successfully updated"
       redirect_to @destination
     else
       render :edit 
       flash[:notice] = "Destination can't be blank. Please try again."
     end
   end

    def destroy
      Destination.find_by_id(params[:id]).destroy

      redirect_to destinations_path
    end

    private

   def destination_params
     params.require(:destination).permit(:city)
   end


end