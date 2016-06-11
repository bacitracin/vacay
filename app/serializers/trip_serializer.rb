class TripSerializer < ActiveModel::Serializer
  attributes :id, :trip_nickname, :start_date, :end_date
  has_one :destination 
  has_one :user
  has_many :attractions
end