class TripsController < ApplicationController

  def new
    @trip = Trip.new
    @destination = Destination.new
  end

end