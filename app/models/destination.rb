class Destination < ActiveRecord::Base
  has_many :trips

  validates :city, presence: true
  validates :city, uniqueness: true

  def trips_attributes=(trip_attributes)
    trips_attributes.each do |trip_attributes| 
    self.trips.build(trip_attributes)
    end
  end

end
