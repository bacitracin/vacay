class AttractionSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :attraction_type, :destination, :trips
end
