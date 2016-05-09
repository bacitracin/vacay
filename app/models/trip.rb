class Trip < ActiveRecord::Base

  belongs_to :user
  belongs_to :destination

  def destination_city=(city)
    self.destination = Destination.find_or_create_by(city: city)
  end

  def destinations_attributes=(destination_attributes)
    destination_attributes.each do |i, destination_attributes| 
      self.build_destination(destination_attributes)
    end
  end


end
 