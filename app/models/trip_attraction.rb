class TripAttraction < ActiveRecord::Base

  belongs_to :trip 
  belongs_to :attraction 
end
