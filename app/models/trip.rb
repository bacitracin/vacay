class Trip < ActiveRecord::Base

  belongs_to :user
  belongs_to :destination
  has_many :trip_attractions
  has_many :attractions, :through => :trip_attractions

  validates_presence_of :trip_nickname, :destination_id
  validates :trip_nickname, length: { minimum: 2}
  #validates_uniqueness_of :trip_nickname 

  #scope :upcoming_trips, -> {where('start_date > ?', Date.today)}
  #scope :past_trips, -> {where('end_date < ?', Date.today)}

  def destination_city=(city)
    self.destination = Destination.find_or_create_by(city: city)
  end

end