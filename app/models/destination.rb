class Destination < ActiveRecord::Base

  has_many :trips
  has_many :users, :through => :trips
  has_many :attractions

  validates_presence_of :city

  def popularity
    self.trips.count
  end

end
