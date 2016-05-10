class Attraction < ActiveRecord::Base
  belongs_to :destination
  belongs_to :trip

  def destination_city=(city)
    self.destination.city = Destination.find_or_create_by(city: city)
  end
  
end
