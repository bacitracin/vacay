class TripSerializer < ActiveModel::Serializer
  attributes :trip_nickname, :start_date, :end_date, :user_id
  has_one :destination #, serializer: TripDestinationSerializer
  has_many :attractions
end