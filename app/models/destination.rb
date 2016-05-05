class Destination < ActiveRecord::Base
  has_many :trips
  has_many :attractions
  has_many :reviews, :through => :attractions
end
