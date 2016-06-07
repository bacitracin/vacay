class TripSerializer < ActiveModel::Serializer
  attributes :id, :trip_nickname, :start_date, :end_date, :destination_id, :user_id
  has_one :destination #, serializer: TripDestinationSerializer
  has_many :attractions
end