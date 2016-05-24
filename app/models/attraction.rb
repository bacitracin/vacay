class Attraction < ActiveRecord::Base
  belongs_to :destination
  has_many :trip_attractions
  has_many :trips, :through => :trip_attractions

  validates_presence_of :name, :destination_id
  validates_uniqueness_of :name

  def destination_city=(city)
    self.destination = Destination.find_or_create_by(city: city)
  end

  def trip_nickname=(trip_nickname)
    @trip = current_user.trips.find_or_create_by(trip_nickname: trip_nickname)
    @trip.attractions << self # didnt i already add this?????
    self.trips << @trip # dupe code???
  end
  
end
