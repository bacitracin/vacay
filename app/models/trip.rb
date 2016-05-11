class Trip < ActiveRecord::Base

  belongs_to :user
  belongs_to :destination
  has_many :trip_attractions
  has_many :attractions, :through => :trip_attractions

  def destination_city=(city)
    self.destination.city = Destination.find_or_create_by(city: city)
  end

end