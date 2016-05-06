class Destination < ActiveRecord::Base
  has_many :trips
  has_many :attractions
  has_many :reviews, :through => :attractions

  def trips_attributes=(trip_attributes)
    trips_attributes.each do |trip_attributes| 
    self.trips.build(trip_attributes)
    end
  end

end
