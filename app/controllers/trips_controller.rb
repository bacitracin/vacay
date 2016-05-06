class TripsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]
  def new

  end

end