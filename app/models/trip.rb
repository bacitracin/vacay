class Trip < ActiveRecord::Base

  belongs_to :user
  belongs_to :destination
  has_many :trip_attractions
  has_many :attractions, :through => :trip_attractions

  validates_presence_of :trip_nickname, :destination_id
  validates_uniqueness_of :trip_nickname #not sure if i want to keep this

  def destination_city=(city)
    self.destination = Destination.find_or_create_by(city: city)
  end

end