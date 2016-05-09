class Destination < ActiveRecord::Base
  has_many :trips
  has_many :users, :through => :trips

  validates :city, presence: true

  def trips_attributes=(trips_attributes)
    trips_attributes.each do |i, trip_attributes| 
      self.trips.build(trip_attributes)
    end
  end

end
