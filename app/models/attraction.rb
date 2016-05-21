class Attraction < ActiveRecord::Base
  belongs_to :destination
  has_many :trip_attractions
  has_many :trips, :through => :trip_attractions
  # add validation for city

  def destination_city=(city)
    self.destination.city = Destination.find_or_create_by(city: city)
  end

  def trip_nickname=(trip_nickname)
    @trip = Trip.find_or_create_by(trip_nickname: trip_nickname)
    @trip.attractions << self # didnt i already add this?????
    self.trips << @trip # dupe code???
  end
  
end
