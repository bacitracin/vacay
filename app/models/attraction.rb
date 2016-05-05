class Attraction < ActiveRecord::Base
  belongs_to :destination
  belongs_to :trip
  has_many :reviews
end
