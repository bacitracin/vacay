class Destination < ActiveRecord::Base

  has_many :trips
  has_many :users, :through => :trips
  has_many :attractions

  validates_presence_of :city
  validates :city, format: { with: /\A[a-z0-9\s]+\Z/i,
    message: "uses letters & spaces only, no special characters or numbers" }
  validates :city, length: { minimum: 2}
  
  def popularity
    self.trips.count
  end

  def self.popularity_sort
    Destination.all.sort_by { |destination| destination.popularity}.reverse
  end

end
