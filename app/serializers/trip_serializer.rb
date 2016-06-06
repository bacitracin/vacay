class TripSerializer < ActiveModel::TripSerializer
  attributes :id, :trip_nickname, :start_date, :end_date, :destination_id, :user_id
end