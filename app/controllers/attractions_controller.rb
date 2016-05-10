class AttractionsController < ApplicationController

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.new(attraction_params)
    @destination = Destination.find_or_create_by(:city => params[:attraction][:destination][:destination_city])
    @attraction.destination_id = @destination.id
    @destination.attractions << @attraction
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

  private

  def attraction_params
    params.require(:attraction).permit(:name,:url, :attraction_type, :destination_city)
  end

end



  

