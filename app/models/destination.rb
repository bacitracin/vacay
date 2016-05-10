class Destination < ActiveRecord::Base
  has_many :trips
  has_many :users, :through => :trips

  validates_presence_of :city

   # def trips_attributes=(trips_attributes)
   #   trips_attributes.each do |i, trip_attributes| 
   #     self.trips.build(trip_attributes)
   #   end
   # end

   
end
