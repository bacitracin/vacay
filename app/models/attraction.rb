class Attraction < ActiveRecord::Base
  belongs_to :destination
  has_many :trip_attractions
  has_many :trips, :through => :trip_attractions

  validates_presence_of :name, :destination_id
  validates_uniqueness_of :name
  validates :name, length: { minimum: 2}

  def destination_city=(city)
    self.destination = Destination.find_or_create_by(city: city)
  end

  def trip_nickname=(trip_nickname)
    @trip = current_user.trips.find_or_create_by(trip_nickname: trip_nickname)
  end
  
end
